<template>
  <div class="the-editable-history-dialog">
    <v-dialog v-model="isShow" fullscreen max-width="500px">
      <v-card class="editable-history-dialog">
        <v-card-title class="headline grey lighten-2">
          {{ cardTitle }}
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
                <VUsersSelector label="歌った人" :multiple="false" :users="users" />
                <VAutocompleteTextField label="曲名" :states="songs" />
                <VAutocompleteTextField label="歌手名" :states="artists" />
                 <v-subheader class="pl-0">キー設定</v-subheader>
                <VSongKeySlider />
              </v-form>
            </v-tab-item>

            <v-tab-item id="detail">
              詳細設定
            </v-tab-item>
          </v-tabs>
        </v-card-text>
        <v-layout wrap class="buttons">
          <v-flex xs6 class="button-outer">
            <v-btn round class="pk-full-width" color="primary">
              登録
            </v-btn>
          </v-flex>
          <v-flex xs6 class="button-outer">
            <v-btn round class="pk-full-width" color="primary">
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
  import DialogComponentMixin from '@mixin/DialogComponentMixin'
  import VAutocompleteTextField from '@component/common/VAutocompleteTextField'
  import VUsersSelector from '@component/common/VUsersSelector'
  import VSongKeySlider from '@component/common/VSongKeySlider'
  import VSatisfactionRate from '@component/common/VSatisfactionRate'
  export default {
    mixins: [DialogComponentMixin],
    components: {
      VAutocompleteTextField,
      VUsersSelector,
      VSongKeySlider,
      VSatisfactionRate
    },
    data: function() {
      return {
        users: [
          { id: 1, display_name: 'ないと', image_url: '/user_icon/sa2knight.png' },
          { id: 2, display_name: 'へたれ', image_url: '/user_icon/hetare.png' },
          { id: 3, display_name: 'ちゃら', image_url: '/user_icon/unagipai.png' },
        ],
        songs: [
        ],
        artists: [
        ]
      }
    },
    computed: {
      cardTitle() {
        return '歌唱履歴作成'
      }
    }
  }
</script>
