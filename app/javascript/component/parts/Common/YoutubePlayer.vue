<template>
  <div class="youtube-player">
    <iframe
      width="100%"
      height="100%"
      :src="url" frameborder="0" allowfullscreen>
    </iframe>
  </div>
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
  }
</script>
