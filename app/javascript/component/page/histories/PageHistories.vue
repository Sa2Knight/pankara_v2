<template>
  <div app>
    <v-container fluid grid-list-md>
      <h1>歌唱履歴一覧予定地</h1>
      <!-- 歌唱履歴一覧 -->
      <!-- TODO: コンポーネント切ったほうが良いかも -->
      <v-layout row wrap class="pb-5" v-if="histories">
        <v-flex xs12 sm12 md6 lg4 v-for="history in histories">
          <v-history-card :history="history" showDate showSongName showArtistName />
          <v-divider />
        </v-flex>
      </v-layout>
    </v-container>
  </div>
</template>

<style lang="scss" scoped>
</style>

<script>
  import { mapState, mapActions } from 'vuex'
  import PageCommonMixin from '@mixin/PageCommonMixin'
  import CONST from '@lib/constants'
  import VHistoryCard from '@component/common/VHistoryCard'
  const namespace = 'histories'

  export default {
    mixins: [PageCommonMixin],
    components: {
      VHistoryCard
    },
    computed: {
      ...mapState(namespace, {
        histories: state => state.histories
      })
    },
    methods: {
      ...mapActions(namespace, [
        'fetchHistories',
      ]),
      ...mapActions('common', [
      ])
    },
    mounted: function() {
      this.$store.dispatch('common/setPageTitle', '歌唱履歴一覧')
      this.fetchHistories(this.$route.query.user_id)
    },
  }
</script>
