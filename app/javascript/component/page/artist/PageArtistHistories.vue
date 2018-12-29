<template>
  <div class="page-artist-histories" v-if="histories">
    <VPaginationWrapper
      :pageOrigin="pageOrigin"
      :totalPages="totalPages"
      :changePage="fetchHistoriesByPage"
    >
      <v-layout row wrap class="pb-5">
        <v-flex xs12 sm12 md6 lg4 v-for="history in histories">
          <VHistoryCard :history="history" :artist="artist" showSongName showDate/>
          <v-divider />
        </v-flex>
      </v-layout>
    </VPaginationWrapper>
  </div>
</template>

<script>
  import { mapState, mapActions } from 'vuex'
  import VPaginationWrapper from '@component/common/VPaginationWrapper'
  import VHistoryCard from '@component/common/VHistoryCard'
  const namespace = 'artist'

  export default {
    components: {
      VPaginationWrapper,
      VHistoryCard
    },
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
  }
</script>
