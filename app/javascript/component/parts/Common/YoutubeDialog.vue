<template>
  <v-dialog v-model="isShow" scrollable max-width="500px">
    <div class="youtube-dialog" v-if="song">
      <div class="youtube-dialog-inner">
        <youtube-player :song="song" />
      </div>
    </div>
  </v-dialog>
</template>

<style lang="scss">
  .youtube-dialog {
    display: table;
    width: 100%;
    height: 40vh;
    .youtube-dialog-inner {
      display: table-cell;
      vertical-align: middle;
    }
  }
</style>

<script>
  import { mapState } from 'vuex'
  export default {
    data: function() {
      return {
        isShow: false
      }
    },
    computed: {
      ...mapState({
        isShowYoutubeDialog: state => state.common.isShowYoutubeDialog,
        song: state => state.common.showingYoutubeSong
      })
    },
    watch: {
      isShow: function(val) {
        if (this.isShowYoutubeDialog && !this.isShow) {
          this.$store.dispatch('hideYoutubeDialog')
        }
      }
    },
    mounted: function() {
      this.isShow = this.isShowYoutubeDialog
    },
    components: {
      YoutubePlayer: require('./YoutubePlayer').default
    },
  }
</script>
