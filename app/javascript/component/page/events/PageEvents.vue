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
  import { mapState, mapActions } from 'vuex'
  import PageCommonMixin from '@mixin/PageCommonMixin'
  import CONST        from '../../../lib/constants'
  const namespace = 'events'

  export default {
    mixins: [PageCommonMixin],
    computed: {
      ...mapState(namespace, {
        isShowSearchDialog: state => state.isShowSearchDialog,
        searchQuery: state => state.searchQuery,
      })
    },
    methods: {
      ...mapActions(namespace, [
        'fetchEvents',
        'showSearchDialog'
      ])
    },
    mounted: function() {
      this.$store.dispatch('common/setPageTitle', 'カラオケ一覧')
      this.fetchEvents()
    },
    components: {
      TheEventCards: require('./parts/TheEventCards').default,
      TheEventsSearchForm: require('./parts/TheEventsSearchForm').default
    }
  }
</script>
