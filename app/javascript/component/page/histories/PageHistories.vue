<template>
  <div app>
    <v-container fluid grid-list-md>
      <h1>あなたの歌唱履歴</h1>
      <VPaginationWrapper v-if="currentUser && histories"
        :pageOrigin="pageOrigin"
        :totalPages="totalPages"
        :changePage="fetchHistoriesByPage"
      >
        <v-layout row wrap class="pb-5">
          <v-flex xs12 sm12 md6 lg4 v-for="history in histories">
            <VHistoryCard :history="history" showSongName songArtistName showDate/>
            <v-divider />
          </v-flex>
        </v-layout>
      </VPaginationWrapper>
    </v-container>
  </div>
</template>

<style lang="scss" scoped>
</style>

<script>
  import { mapState, mapActions } from 'vuex'
  import PageCommonMixin from '@mixin/PageCommonMixin'
  import CONST from '@lib/constants'
  import VPaginationWrapper from '@component/common/VPaginationWrapper'
  import VHistoryCard from '@component/common/VHistoryCard'
  const namespace = 'histories'

  export default {
    mixins: [PageCommonMixin],
    components: {
      VPaginationWrapper,
      VHistoryCard
    },
    computed: {
      ...mapState(namespace, {
        histories: state => state.histories,
        pageOrigin: state => state.pager.page,
        totalPages: state => state.pager.totalPages,
      })
    },
    methods: {
      ...mapActions(namespace, [
        'fetchHistories',
        'changePage'
      ]),
      fetchHistoriesByPage: function(page) {
        this.changePage(page)
        this.fetchHistories(this.currentUser.id)
      }
    },
    mounted: function() {
      this.$store.dispatch('common/setPageTitle', '歌唱履歴一覧')
      this.fetchHistories(this.currentUser.id)
    },
  }
</script>
