<template>
  <div class="page-artist-overview">
    <template v-if="artist">
      <h1>{{ artist.name }}</h1>
      <p class="description">
        {{ description }}
        <a v-if="wikipediaUrl" :href="wikipediaUrl">
          (wikipedia引用)
        </a>
      </p>
      <v-divider />
      <h1>楽曲一覧</h1>
      <TheArtistSongs />
    </template>
  </div>
</template>

<style lang="scss" scoped>
.description {
  padding: 5px;
}
.chips-outer {
  > * {
    height: 1.2em;
  }
}
</style>

<script>
  import { mapState } from 'vuex'
  import TheArtistSongs from '@component/page/artist/the/TheArtistSongs'

  export default {
    components: {
      TheArtistSongs
    },
    computed: {
      ...mapState('artist', {
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
  }
</script>
