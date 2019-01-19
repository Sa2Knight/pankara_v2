<template>
  <div class="outer mb-2">
    <div class="header py-3">
      <h1>{{ song.name }}</h1>
      <h2 class="link" @click="moveToArtistPage">{{ song.artist.name}}</h2>
    </div>
    <div class="player">
      <YoutubePlayer :song="song" />
    </div>
  </div>
</template>

<style lang="scss" scoped>
.outer {
  text-align: center;
  .player {
    width: 80%;
    margin: 0 10%;
  }
}
</style>

<script>
import { mapState } from 'vuex'
import { ROUTES } from '../../../lib/routes'
import YoutubePlayer from '@component/parts/Common/YoutubePlayer'

export default {
  components: {
    YoutubePlayer
  },
  computed: {
    ...mapState('song', {
      song: state => state.song
    })
  },
  methods: {
    moveToArtistPage() {
      this.$router.push(ROUTES.ARTIST_PATH(this.song.artist.id))
    }
  }
}
</script>
