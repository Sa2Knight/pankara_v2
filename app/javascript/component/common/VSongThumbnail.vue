<template>
  <div class="v-song-thumbnail">
    <img :src="url">
  </div>
</template>

<script>
  export default {
    computed: {
      url: function() {
        return `https://i.ytimg.com/vi/${this.song.url}/mqdefault.jpg`
      }
    },
    props: {
      // 楽曲オブジェクト
      // 楽曲IDやYoutube用URLを持っていることを想定
      song: {
        type: Object,
        required: true
      }
    }
  }
</script>
