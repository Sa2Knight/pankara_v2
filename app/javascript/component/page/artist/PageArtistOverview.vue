<template>
  <div class="page-artist-overview">
    <template v-if="artist">
      <v-box label="基本情報" />
        <p class="description">
          {{ description }}
          <a v-if="wikipediaUrl" :href="wikipediaUrl">
            (wikipedia引用)
          </a>
        </p>
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

<style lang="scss" scoped>
.description {
  padding: 5px;
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
      description: function() {
        if (this.artist.description) {
          return `${this.artist.description}`
        } else {
          return `"${this.artist.name}" に関する情報がありません`
        }
      },
      wikipediaUrl: function() {
        return this.artist.description ? this.artist.url : null;
      }
    },
    components: {
      VSongCard: require('../../common/VSongCard').default,
      VBox: require('../../common/VBox').default
    }
  }
</script>
