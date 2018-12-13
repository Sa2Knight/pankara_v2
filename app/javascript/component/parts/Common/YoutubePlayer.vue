<template>
  <div class="youtube-player">
    <div class="thumbnail" v-show="showingThumbnail" @click="onClick">
      <VSongThumbnail :song="song" />
      <v-icon class="link play-icon">fas fa-play-circle</v-icon>
    </div>
    <div class="player" v-show="!showingThumbnail">
      <iframe
        width="640"
        height="360"
        :src="url" frameborder="0" allowfullscreen>
      </iframe>
    </div>
  </div>
</template>

<style lang="scss" scoped>
.youtube-player {
  .thumbnail {
    position: relative;
    width: 100%;
    height: auto;
    .play-icon {
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translate(-50%,-50%);
      font-size: 6em;
      color: #888;
      opacity: 0.75;
    }
  }
  .player {
    width: 100%;
    padding-bottom: 56.25%;
    height: 0px;
    position: relative;
    iframe {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
    }
  }
}
</style>

<script>
  import VSongThumbnail from '@component/common/VSongThumbnail'
  export default {
    data: () => ({
      showingThumbnail: true
    }),
    props: {
      song: { // song.url必須
        type: Object,
        required: true,
      },
    },
    computed: {
      url: function() {
        return `https://www.youtube.com/embed/${this.song.url}`
      },
    },
    methods: {
      onClick: function() {
        this.showingThumbnail = false
      }
    },
    components: {
      VSongThumbnail
    }
  }
</script>
