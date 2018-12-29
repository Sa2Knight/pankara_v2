<template>
  <div app>
    <v-container fluid grid-list-md>
      <h1>持ち歌一覧</h1>
      <VPaginationWrapper v-if="mySongs"
        :pageOrigin="pageOrigin"
        :totalPages="totalPages"
        :changePage="fetchMySongsByPage"
      >
        <v-layout row wrap class="pb-5">
          <v-flex xs6 sm4 md3 lg2 v-for="song in mySongs">
            <v-song-card :song="song" />
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
  import VSongCard from '@component/common/VSongCard'
  const namespace = 'user'

  export default {
    mixins: [PageCommonMixin],
    components: {
      VPaginationWrapper,
      VSongCard
    },
    computed: {
      ...mapState(namespace, {
        mySongs: state => state.mySongs,
        pageOrigin: state => state.mySongsPager.page,
        totalPages: state => state.mySongsPager.totalPages,
      })
    },
    methods: {
      ...mapActions(namespace, [
        'fetchMySongs',
        'changePage'
      ]),
      fetchMySongsByPage: function(page) {
        this.changePage(page)
        this.fetchMySongs(this.$route.params.id)
      }
    },
    mounted: function() {
      this.$store.dispatch('common/setPageTitle', '持ち歌一覧')
      this.fetchMySongsByPage()
    },
  }
</script>
