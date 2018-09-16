<template>
  <div class="history-dialog">
    <v-dialog v-model="isShow" scrollable max-width="350px">
      <v-card class="history-detail" v-if="history">
        <v-card-title class="headline">歌唱履歴詳細</v-card-title>
        <v-card-text>
          <table class="history-table">
            <tr>
              <th>ユーザー</th>
              <td><v-user-icon :user="history.user" show-display-name /></td>
            </tr>
            <tr>
              <th>カラオケ名</th>
              <td>
                <a @click="link_to_event">{{ history.event.title }}</a>
              </td>
            </tr>
            <tr>
              <th>日時</th>
              <td>{{ history.event.datetime }}</td>
            </tr>
            <tr>
              <th>曲名</th>
              <td>
                <a @click="link_to_song">{{ history.song.name }}</a>
              </td>
            </tr>
            <tr>
              <th>歌手名</th>
              <td>{{ history.song.artist.name }}</td>
            </tr>
            <tr>
              <th>キー</th>
              <td>{{ history.key }}</td>
            </tr>
            <tr>
              <th>満足度</th>
              <td>{{ history.satisfaction }}</td>
            </tr>
            <tr>
              <th>採点方法</th>
              <td>{{ history.score_type }}</td>
            </tr>
            <tr>
              <th>得点</th>
              <td>{{ history.score }}</td>
            </tr>
          </table>
        </v-card-text>
      </v-card>
    </v-dialog>
  </div>
</template>

<style lang="scss" scoped>
.history-table {
  width: 100%;
  text-align: center;
  tr {
    border: 1px solid;
  }
  td {
    display: inline-block;
  }
}
</style>

<script>
  // TODO: YoutubeDialogとmixinなりできる？
  import { mapState } from 'vuex'
  import ROUTES from '../../../lib/routes'
  export default {
    data: function() {
      return {
        isShow: false
      }
    },
    computed: {
      ...mapState({
        isShowHistoryDialog: state => state.common.isShowHistoryDialog,
        history: state => state.common.showingHistory,
      })
    },
    watch: {
      isShow: function(val) {
        if (this.isShowHistoryDialog && !this.isShow) {
          this.$store.dispatch('hideHistoryDialog')
        }
      }
    },
    mounted: function() {
      this.isShow = this.isShowHistoryDialog
    },
    methods: {
      link_to_event: function() {
        // TODO: 各リンクでdispatchするの辛いのでなんとかする
        this.$router.push(ROUTES.EVENT_PATH(this.history.event.id))
        this.$store.dispatch('hideHistoryDialog')
      },
      link_to_song: function() {
        this.$router.push(ROUTES.SONG_PATH(this.history.song.id))
        this.$store.dispatch('hideHistoryDialog')
      }
    },
    components: {
      VUserIcon: require('../../common/VUserIcon').default
    }
  }
</script>
