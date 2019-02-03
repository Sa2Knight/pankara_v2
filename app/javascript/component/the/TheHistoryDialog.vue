<!-- TODO: TheHistoryDialogにするべきで、partsではないだろ -->
<template>
  <div class="history-dialog">
    <v-dialog v-model="isShow" scrollable max-width="450px">
      <v-card class="history-detail" v-if="history">
        <div class="top clearfix">
          <div class="song-info">
            <h1 class="collapse">
              <router-link class="underline" :to="songPage">
                {{ history.song.name }}
              </router-link>
            </h1>
            <h2 class="collapse">
              <router-link  class="underline" :to="artistPage">
                {{ history.song.artist.name }}
              </router-link>
            </h2>
          </div>
          <div class="avatar">
            <img :src="history.user.image_url" >
          </div>
        </div>
        <div class="middle">
          <VYoutubePlayer :song="history.song" />
        </div>
        <div class="bottom">
          <div class="history-info">
            <div>
              <table>
                <tr>
                  <th class="nowrap">日付</th>
                  <td class="nowrap">{{ history.event.date }}</td>
                </tr>
                <tr>
                  <th class="nowrap">カラオケ</th>
                  <td class="nowrap">
                    <router-link class="underline" :to="eventPage">
                      {{ history.event.title }}
                    </router-link>
                    </a>
                  </td>
                </tr>
                <tr>
                  <th class="nowrap">ユーザー</th>
                  <td class="nowrap">
                    {{ history.user.display_name }}
                  </td>
                </tr>
                <tr>
                  <th class="nowrap">キー</th>
                  <td class="nowrap">{{ history.key }}</td>
                </tr>
                <tr v-if="history.satisfaction">
                  <th class="nowrap">満足度</th>
                  <td class="nowrap">
                    <VSatisfactionRate readonly narrow :satisfaction="history.satisfaction" />
                  </td>
                </tr>
                <template v-if="history.score_type && history.score">
                <tr>
                  <th class="nowrap">採点</th>
                  <td class="nowrap">
                    <VScoreTypeLabel :type="history.score_type" />
                  </td>
                </tr>
                <tr>
                  <th class="nowrap">得点</th>
                  <td class="nowrap">{{ history.score }} 点</td>
                </tr>
                </template>
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
        width: 100%;
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
          padding: 0.2em;
        }
        th {
          background: #295890;
          vertical-align: middle;
          overflow: visible;
          position: relative;
          color: #fff;
          font-weight: normal;
          white-space: nowrap;
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
  import { ROUTES } from '@lib/routes'
  import VYoutubePlayer from '@component/common/VYoutubePlayer'
  import VScoreTypeLabel from '@component/common/VScoreTypeLabel'
  import VSatisfactionRate from '@component/common/VSatisfactionRate'
  const namespace = 'common'
  export default {
    components: {
      VYoutubePlayer,
      VScoreTypeLabel,
      VSatisfactionRate
    },
    data: function() {
      return {
        isShow: false
      }
    },
    computed: {
      ...mapState(namespace, {
        isShowHistoryDialog: state => state.isShowHistoryDialog,
        history: state => state.showingHistory,
      }),
      eventPage: function() {
        return {
          name: 'Event',
          params: {
            id: this.history.event.id
          }
        }
      },
      songPage: function() {
        return {
          name: 'Song',
          params: {
            id: this.history.song.id
          }
        }
      },
      artistPage: function() {
        return {
          name: 'Artist',
          params: {
            id: this.history.song.artist.id
          }
        }
      }
    },
    methods: {
      ...mapActions(namespace, [
        'hideHistoryDialog',
      ])
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
  }
</script>
