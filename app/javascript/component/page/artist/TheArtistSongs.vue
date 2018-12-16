<template>
  <div class="the-artist-songs">
    <div class="chips-outer">
      <v-chip small color="primary" text-color="white">みんなの歌唱回数</v-chip>
      <v-chip small color="green" text-color="white">あなたの歌唱回数</v-chip>
    </div>
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
  const namespace = 'artist'

  export default {
    computed: {
      ...mapState(namespace, {
        artist: store => store.artist,
      }),
    },
    components: {
      VSongCard: require('../../common/VSongCard').default,
    }
  }
</script>
