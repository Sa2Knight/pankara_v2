<template>
  <div class="page-song-detail mb-2">
    <div class="header py-3">
      <h1>{{ song.name }}</h1>
      <h2>{{ song.artist.name}}</h2>
    </div>
    <youtube-player :song="song" />
  </div>
</template>

<style lang="scss">
.page-song-detail {
  text-align: center;
}
</style>

<script>
import { mapState } from 'vuex'
export default {
  computed: {
    ...mapState({
      song: state => state.song.song
    })
  },
  components: {
    YoutubePlayer: require('../../parts/Common/YoutubePlayer').default
  }
}
</script>
