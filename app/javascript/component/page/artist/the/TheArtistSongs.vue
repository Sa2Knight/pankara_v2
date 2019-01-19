<template>
  <div class="the-artist-songs">
    <TheSangCountRemarks />
    <v-layout row wrap class="pb-5">
      <v-flex xs6 sm4 md3 lg2 v-for="song in artist.songs">
        <v-song-card :song="song" />
        <v-divider />
      </v-flex>
    </v-layout>
  </div>
</template>

<style lang="scss" scoped>
.chips-outer {
  margin-top: 1em;
  text-align: right;
  > * {
    height: 1.2em;
  }
}
</style>

<script>
  import { mapState } from 'vuex'
  import TheSangCountRemarks from '@component/the/TheSangCountRemarks'
  import VSongCard from '@component/common/VSongCard'

  export default {
    components: {
      TheSangCountRemarks,
      VSongCard
    },
    computed: {
      ...mapState('artist', {
        artist: store => store.artist,
      }),
    },
  }
</script>
