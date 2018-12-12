<template>
  <div class="youtube-player">
    <div class="thumbnail">
      <VSongThumbnail :song="song" />
    </div>
    <div class="player">
      <iframe
        width="100%"
        height="100%"
        :src="url" frameborder="0" allowfullscreen>
      </iframe>
    </div>
  </div>
</template>

<style lang="scss" scoped>
.youtube-player {
  position: relative;
  .thumbnail,.player {
    position: absolute;
    left: 0;
    top: 0;
    width: 100%;
    height: auto;
  }
}
</style>

<script>
  import VSongThumbnail from '@component/common/VSongThumbnail'
  export default {
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
    components: {
      VSongThumbnail
    }
  }
</script>
