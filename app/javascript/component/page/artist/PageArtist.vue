<template>
  <div class="artist">
    <v-tabs icons-and-text fixed-tabs centered dark color="grey lighten-5">
      <v-tabs-slider color="blue"></v-tabs-slider>
      <v-tab href="#overview">
        概要<v-icon>fas fa-clipboard-list</v-icon>
      </v-tab>
      <v-tab href="#songs">
        楽曲一覧<v-icon>fas fa-music</v-icon>
      </v-tab>
      <v-tab href="#history">
        歌唱履歴<v-icon>fas fa-list-ul</v-icon>
      </v-tab>
      <v-tab-item id="overview"><page-artist-overview /></v-tab-item>
      <v-tab-item id="songs"><page-artist-songs /></v-tab-item>
      <v-tab-item id="history"><page-artist-histories /></v-tab-item>
    </v-tabs>
  </div>
</template>

<script>
  import { mapState, mapActions } from 'vuex'
  import PageCommonMixin from '@mixin/PageCommonMixin'
  const namespace = 'artist'

  export default {
    mixins: [PageCommonMixin],
    computed: {
      ...mapState(namespace, {
        artist: state => state.artist
      })
    },
    methods: {
      ...mapActions(namespace, [
        'fetchArtist',
        'fetchHistoriesByPage'
      ])
    },
    mounted: function() {
      Promise.resolve()
      .then(() => this.fetchArtist(this.$route.params.id))
      .then(() => this.fetchHistoriesByPage(this.pageOrigin))
      .then(() => this.$store.dispatch('common/setPageTitle', this.artist.name))
    },
    components: {
      PageArtistOverview: require('./PageArtistOverview').default,
      PageArtistSongs:    require('./PageArtistSongs').default,
      PageArtistHistories: require('./PageArtistHistories').default,
    }
  }
</script>
