<!-- TODO: TheHistoryDialogにするべきで、partsではないだろ -->
<template>
  <div class="history-dialog">
    <v-dialog v-model="isShow" scrollable max-width="100%">
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
            history-info
            <div class="left"></div>
            <div class="right"></div>
          </div>
          <div class="comment"></div>
        </div>
      </v-card>
    </v-dialog>
  </div>
</template>

<style lang="scss" scoped>
.history-detail {
  width: 100%;
  padding: 1em 2em;
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
