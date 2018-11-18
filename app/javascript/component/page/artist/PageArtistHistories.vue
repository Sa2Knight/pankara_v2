<template>
  <div class="page-artist-histories" v-if="histories">
    <v-pagination-wrapper
      :pageOrigin="pageOrigin"
      :totalPages="totalPages"
      :changePage="fetchHistoriesByPage"
    >
      <!-- TODO PageEventの歌唱履歴と同じなら汎用化 -->
      <v-layout row wrap class="pb-5">
        <v-flex xs12 sm12 md6 lg4 v-for="history in histories">
          <v-history-card :history="history" :artist="artist" showSongName showDate/>
          <v-divider />
        </v-flex>
      </v-layout>
    </v-pagination-wrapper>
  </div>
</template>

<script>
  import { mapState, mapActions } from 'vuex'
  const namespace = 'artist'

  export default {
    computed: {
      ...mapState(namespace, {
        artist:    state => state.artist,
        histories: state => state.histories,
        pageOrigin: state => state.historiesPager.page,
        totalPages: state => state.historiesPager.totalPages,
      })
    },
    methods: {
      ...mapActions(namespace, [
        'fetchHistoriesByPage'
      ]),
    },
    components: {
      VPaginationWrapper: require('../../common/VPaginationWrapper').default,
      VHistoryCard: require('../../common/VHistoryCard').default
    }
  }
</script>
