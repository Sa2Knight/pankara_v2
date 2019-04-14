<template>
  <div class="the-editable-history-dialog">
    <v-dialog v-model="isShow" :fullscreen="isMobile" max-width="500px">
      <v-card class="editable-history-dialog">
        <v-card-title class="headline grey lighten-2">
          歌唱履歴作成
        </v-card-title>
        <v-card-text>

          <v-tabs icons-and-text fixed-tabs centered dark color="grey lighten-5">
            <v-tab href="#basic">
              基本<v-icon>fas fa-music</v-icon>
            </v-tab>
            <v-tab href="#detail">
              詳細<v-icon>fas fa-cog</v-icon>
            </v-tab>

            <v-tab-item id="basic">
              <v-form class="history-form">
                <VUsersSelector v-model="userId" label="歌った人" :multiple="false" :users="users" />
                <VAutocompleteTextField
                  v-model="songName"
                  label="曲名"
                  :states="songNames"
                  @change="onChangeSongName"
                />
                <VAutocompleteTextField
                  v-model="artistName"
                  label="歌手名"
                  :states="artistNames"
                 />
                 <v-subheader class="pl-0">キー設定</v-subheader>
                <VSongKeySlider v-model="key" />
              </v-form>
            </v-tab-item>

            <v-tab-item id="detail">
              <VScoreEditor v-model="scoreSet" />

              <v-label>満足度</v-label>
              <VSatisfactionRate v-model="satisfaction" />
            </v-tab-item>

          </v-tabs>
        </v-card-text>

        <v-layout wrap class="buttons">
          <v-flex xs6 class="button-outer">
            <v-btn round @click="submit" class="pk-full-width" color="primary">
              登録
            </v-btn>
          </v-flex>
          <v-flex xs6 class="button-outer">
            <v-btn round @click="close" class="pk-full-width" color="primary">
              キャンセル
            </v-btn>
          </v-flex>
        </v-layout>

      </v-card>
    </v-dialog>
  </div>
</template>

<style lang="scss" scoped>
.editable-history-dialog {
  position: relative;

  .history-form {
    margin: 0.5em;
  }
  .buttons {
    width: 100%;
    position: absolute;
    bottom: 1em;
    right: 0.5em;

    .button-outer {
      padding: 0 0.5em;
    }
  }
}
</style>

<script>
  import { mapActions, mapState } from 'vuex'
  import DialogComponentMixin from '@mixin/DialogComponentMixin'
  import VAutocompleteTextField from '@component/common/VAutocompleteTextField'
  import VUsersSelector from '@component/common/VUsersSelector'
  import VSongKeySlider from '@component/common/VSongKeySlider'
  import VSatisfactionRate from '@component/common/VSatisfactionRate'
  import VScoreEditor from '@component/common/VScoreEditor'
  export default {
    mixins: [DialogComponentMixin],
    components: {
      VAutocompleteTextField,
      VUsersSelector,
      VSongKeySlider,
      VSatisfactionRate,
      VScoreEditor
    },
    data: function() {
      return {
        userId: null,
        songName: '',
        artistName: '',
        key: 0,
        scoreSet: {
          scoreType: 0,
          score: null
        },
        satisfaction: 5,
      }
    },
    computed: {
      ...mapState('common', [
        'currentUser'
      ]),
      ...mapState('event', [
        'event'
      ]),
      ...mapState('songs', [
        'songNames'
      ]),
      ...mapState('artist', [
        'artistNames'
      ]),
      users() {
        if (this.event) {
          return this.event.members.map((member) => member.user)
        } else {
          return []
        }
      }
    },
    methods: {
      ...mapActions('common', [
        'createHistory',
        'hideEditableHistoryDialog'
      ]),
      ...mapActions('songs', [
        'fetchSongNames'
      ]),
      ...mapActions('artist', [
        'fetchArtistNames'
      ]),
      ...mapActions('event', [
        'fetchEvent'
      ]),
      // 曲名が変更されたら、曲名を元に歌手名を取得する
      // 歌手名が１件のみだった場合は、それを歌手名フィールドに入力する
      // TODO: 曲名に依存せずに歌手名検索できるように
      onChangeSongName() {
        this.$nextTick(() => {
          this.fetchArtistNames({songName: this.songName}).then(() => {
            if (this.artistNames.length === 1) {
              this.artistName = this.artistNames[0]
            }
          })
        })
      },
      // 歌唱履歴を新規作成
      // 完了後にカラオケ情報をリロードする
      submit() {
        const params = {
          event_id: this.event.id,
          user_id: this.userId,
          song_name: this.songName,
          artist_name: this.artistName,
          key: this.key
        }
        this.createHistory(params).then(() => { this.fetchEvent(this.event.id) })
      },
      // ダイアログを閉じる
      close() {
        this.hideEditableHistoryDialog()
      }
    },
    watch: {
      // REVIEW: 1文字入力ごとにリクエスト飛ぶの辛いかも
      songName: function(v) {
        this.fetchSongNames(v)
      }
    },
    // マウント時に、自身を歌った人の初期値にする
    mounted: function() {
      if (this.currentUser && this.users.find((user) => user.id === this.currentUser.id)) {
        this.userId = this.currentUser.id
      } else {
        this.userId = null
      }
    }
  }
</script>
