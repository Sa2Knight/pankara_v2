<template>
  <div class="outer mb-2">
    <div class="header py-3">
      <h1>{{ song.name }}</h1>
      <h2>{{ song.artist.name}}</h2>
    </div>

    <youtube-player :song="song" />
  </div>
</template>

<style lang="scss" scoped>
  .outer {
    text-align: center;
  }
</style>

<script>
import { mapState } from 'vuex'
const namespace = 'song'

export default {
  computed: {
    ...mapState(namespace, {
      song: state => state.song
    })
  },
  components: {
    VBox: require('../../common/VBox').default,
    YoutubePlayer: require('../../parts/Common/YoutubePlayer').default,
  }
}
</script>
