<!-- TODO: TheHistoryDialogにするべきで、partsではないだろ -->
<template>
  <div class="history-dialog">
    <v-dialog v-model="isShow" scrollable max-width="450px">
      <v-card class="history-detail" v-if="history">
        <div class="top clearfix">
          <div class="song-info">
            <h1 class="collapse">{{ history.song.name }}</h1>
            <h2 class="collapse">{{ history.song.artist.name }}</h2>
          </div>
          <div class="avatar">
            <img :src="history.user.image_url" >
            <span class="collapse">{{ history.user.display_name }}</span>
          </div>
        </div>
        <div class="middle">
          <YoutubePlayer :song="history.song" />
        </div>
        <div class="bottom">
          <div class="history-info">
            <div>
              <table>
                <tr>
                  <th class="nowrap">日付</th>
                  <td class="nowrap">{{ history.event.datetime }}</td>
                </tr>
                <tr>
                  <th class="nowrap">カラオケ</th>
                  <td class="nowrap">{{ history.event.title }}</td>
                </tr>
                <tr>
                  <th class="nowrap">キー</th>
                  <td class="nowrap">{{ history.key }}</td>
                </tr>
                <tr>
                  <th class="nowrap">満足度</th>
                  <td class="nowrap">{{ history.satisfaction }}</td>
                </tr>
                <tr>
                  <th class="nowrap">コメント</th>
                  <td>{{ history.comment }}</td>
                </tr>
              </table>
            </div>
          </div>
        </div>
      </v-card>
    </v-dialog>
  </div>
</template>

<style lang="scss" scoped>
.history-detail {
  width: 100%;
  max-width: 450px;
  padding: 0.5em 0.5em;
  border: 1em solid;
  .top {
    .song-info {
      float: left;
      width: 85%;
      h1,h2 {
        text-align: center;
      }
    }
    .avatar {
      float: right;
      width: 15%;
      text-align: center;
      img {
        width: 90%;
        border-radius: 50%;
      }
      span {
        display: inline-block;
        margin-top: -0.5em;
      }
    }
  }
  .bottom {
    .history-info {
      width: 100%;
      padding-top: 1em;
      table {
        width: 100%;
        margin: 0 auto;
        border-collapse: separate;
        td, th {
          padding: 0.3em;
        }
        th {
          background: #295890;
          vertical-align: middle;
          width: 100px;
          overflow: visible;
          position: relative;
          color: #fff;
          font-weight: normal;
          &:after {
            left: 100%;
            top: 50%;
            border: solid transparent;
            content: " ";
            height: 0;
            width: 0;
            position: absolute;
            pointer-events: none;
            border-color: rgba(136, 183, 213, 0);
            border-left-color: #295890;
            border-width: 0.5em;
            margin-top: -0.5em;
          }
        }
        td {
          background: #f8f8f8;
          padding-left: 20px;
        }
      }
    }
  }
}
</style>

<script>
  // TODO: YoutubeDialogとmixinなりできる？
  import { mapState, mapActions } from 'vuex'
  import ROUTES from '../../../lib/routes'
  import YoutubePlayer from '@component/parts/Common/YoutubePlayer'
  const namespace = 'common'
  export default {
    data: function() {
      return {
        isShow: false
      }
    },
    computed: {
      ...mapState(namespace, {
        isShowHistoryDialog: state => state.isShowHistoryDialog,
        history: state => state.showingHistory,
      })
    },
    methods: {
      ...mapActions(namespace, [
        'hideHistoryDialog',
      ]),
      link_to_event: function() {
        // TODO: 各リンクでdispatchするの辛いのでなんとかする
        this.$router.push(ROUTES.EVENT_PATH(this.history.event.id))
        this.hideHistoryDialog()
      },
      link_to_song: function() {
        this.$router.push(ROUTES.SONG_PATH(this.history.song.id))
        this.hideHistoryDialog()
      },
      link_to_artist: function() {
        this.$router.push(ROUTES.ARTIST_PATH(this.history.song.artist.id))
        this.hideHistoryDialog()
      }
    },
    watch: {
      isShow: {
        handler: function(val) {
          if (this.isShowHistoryDialog && !this.isShow) {
            this.hideHistoryDialog()
          }
        },
      }
    },
    mounted: function() {
      this.isShow = this.isShowHistoryDialog
    },
    components: {
      YoutubePlayer,
    }
  }
</script>
