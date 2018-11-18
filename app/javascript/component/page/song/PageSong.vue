<template>
  <div class="page-song">
    <div v-if="song">
      <v-tabs icons-and-text fixed-tabs centered dark color="grey lighten-5">
        <!-- タブメニュー -->
        <v-tabs-slider color="blue"></v-tabs-slider>
        <v-tab href="#overview">
          概要<v-icon>fas fa-clipboard-list</v-icon>
        </v-tab>
        <v-tab href="#history">
          歌唱履歴<v-icon>fas fa-list-ul</v-icon>
        </v-tab>

        <v-tab-item id="overview"><page-song-overview /></v-tab-item>
        <v-tab-item id="history"><page-song-histories /></v-tab-item>

      </v-tabs>
    </div>
  </div>
</template>

<script>
  import { mapState, mapActions } from 'vuex'
  const namespace = 'song'

  export default {
    computed: {
      ...mapState(namespace, {
        song: store => store.song
      })
    },
    methods: {
      ...mapActions(namespace, [
        'fetchSong'
      ]),
      // APIから楽曲詳細をフェッチ
      fetch: function() {
        this.fetchSong(this.$route.params.id).then(() => {
          this.$store.dispatch('common/setPageTitle', this.song.name)
        })
      }
    },
    mounted: function() {
      this.fetch()
    },
    components: {
      PageSongOverview: require('./PageSongOverview').default,
      PageSongHistories: require('./PageSongHistories').default,
    },
  }
</script>
