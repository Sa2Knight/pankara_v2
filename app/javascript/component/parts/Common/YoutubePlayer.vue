<template>
  <v-dialog v-model="isShow" scrollable max-width="500px">
    <div class="youtube-player" v-if="song">
      <div class="youtube-player-inner">
        <iframe
          width="100%"
          height="100%"
          :src="url" frameborder="0" allowfullscreen>
        </iframe>
      </div>
    </div>
  </v-dialog>
</template>

<style lang="scss">
  .youtube-player {
    display: table;
    width: 100%;
    height: 40vh;
    .youtube-player-inner {
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
      url: function() {
        return `https://www.youtube.com/embed/${this.song.url}`
      },
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
    }
  }
</script>
