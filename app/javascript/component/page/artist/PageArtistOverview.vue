<template>
  <div class="page-artist-overview">
    <template v-if="artist">
      <v-box label="基本情報" />
      <v-box label="楽曲一覧">
        <v-layout row wrap class="pb-5">
          <v-flex xs12 sm6 md4 lg3 v-for="song in artist.songs">
            <v-song-card :song="song" />
            <v-divider />
          </v-flex>
        </v-layout>
      </v-box>
    </template>
  </div>
</template>

<script>
  import { mapState } from 'vuex'
  export default {
    computed: {
      ...mapState({
        artist: store => store.artist.artist,
      })
    },
    components: {
      VSongCard: require('../../common/VSongCard').default,
      VBox: require('../../common/VBox').default
    }
  }
</script>
