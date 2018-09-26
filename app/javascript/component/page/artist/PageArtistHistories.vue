<template>
  <div class="page-artist-histories" v-if="histories">
    <v-pagination-wrapper
      :pageOrigin="pageOrigin"
      :totalPages="totalPages"
      :changePage="changePage"
    >
      <!-- TODO PageEventの歌唱履歴と同じなら汎用化 -->
      <v-layout row wrap class="pb-5">
        <v-flex xs12 sm6 md6 lg4 v-for="history in histories">
          <v-history-card :history="history" :artist="artist" />
          <v-divider />
        </v-flex>
      </v-layout>
    </v-pagination-wrapper>
  </div>
</template>

<script>
  import { mapState } from 'vuex'
  export default {
    computed: {
      ...mapState({
        artist:    state => state.artist.artist,
        histories: state => state.artist.histories,
        pageOrigin: state => state.artist.historiesPager.page,
        totalPages: state => state.artist.historiesPager.totalPages,
      })
    },
    methods: {
      changePage: function() {
        this.$store.dispatch('changePage', page)
        this.$store.dispatch('fetchHistories')
      }
    },
    components: {
      VPaginationWrapper: require('../../common/VPaginationWrapper').default,
      VHistoryCard: require('../../common/VHistoryCard').default
    }
  }
</script>
