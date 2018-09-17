<template>
  <div app>
    <v-container fluid grid-list-md>
      <!-- カラオケ一覧 -->
      <the-event-cards />

      <!-- 検索フォームボタン -->
      <v-btn v-show="true" @click="showSearchDialog"
             color="gray" class="elevation-12" fixed bottom right fab>
        <v-icon>search</v-icon>
      </v-btn>
    </v-container>

    <!-- 検索フォームをダイアログで描画 -->
    <v-dialog v-model="isShowSearchDialog" max-width="500px" persistent>
      <the-events-search-form/>
    </v-dialog>
  </div>
</template>

<script>
  import { mapState } from 'vuex'
  import CONST        from '../../../lib/constants'
  export default {
    computed: {
      ...mapState({
        isShowSearchDialog: state => state.events.isShowSearchDialog,
        searchQuery: state => state.events.searchQuery,
      })
    },
    methods: {
      fetch: function() {
        this.$store.dispatch('fetchEvents')
      },
      showSearchDialog: function() {
        this.$store.dispatch('showSearchDialog')
      },
    },
    mounted: function() {
      this.$store.dispatch('setPageTitle', 'カラオケ一覧')
      this.fetch()
    },
    components: {
      TheEventCards: require('./parts/TheEventCards').default,
      TheEventsSearchForm: require('./parts/TheEventsSearchForm').default
    }
  }
</script>
