<template>
  <div class="song">
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
        <v-tab href="#aggregate">
          集計<v-icon>fas fa-chart-pie</v-icon>
        </v-tab>

        <v-tab-item id="overview"><song-detail /></v-tab-item>
        <v-tab-item id="history"><song-histories /></v-tab-item>
        <v-tab-item id="aggregate">集計情報</v-tab-item>

      </v-tabs>
    </div>
  </div>
</template>

<script>
  import { mapState } from 'vuex'
  export default {
    computed: {
      ...mapState({
        song: store => store.song.song
      })
    },
    methods: {
      // APIから楽曲詳細をフェッチ
      fetch: function() {
        this.$store.dispatch('fetchSong', this.$route.params.id)
      }
    },
    mounted: function() {
      this.fetch()
    },
    components: {
      SongDetail: require('./SongDetail').default,
      SongHistories: require('./SongHistories').default,
    },
  }
</script>
