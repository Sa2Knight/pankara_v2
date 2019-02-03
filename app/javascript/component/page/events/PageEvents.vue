<template>
  <div app>
    <v-container fluid grid-list-md>
      <TheEditableHistoryDialog />
    </v-container>

    <!-- 検索フォームをダイアログで描画 -->
    <v-dialog v-model="isShowSearchDialog" max-width="500px" persistent>
      <TheEventsSearchForm />
    </v-dialog>
  </div>
</template>

<style lang="scss" scoped>
.buttons {
  button {
    bottom: 0.5em;
    &.create-btn {
      right: 64px;
    }
  }
}
</style>

<script>
  import { mapState, mapActions } from 'vuex'
  import PageCommonMixin from '@mixin/PageCommonMixin'
  import CONST from '@lib/constants'
  import TheEventCards from '@component/page/events/the/TheEventCards'
  import TheEventsSearchForm from '@component/page/events/the/TheEventsSearchForm'
  import TheEditableHistoryDialog from '@component/the/TheEditableHistoryDialog'

  export default {
    mixins: [PageCommonMixin],
    components: {
      TheEventCards,
      TheEventsSearchForm,
      TheEditableHistoryDialog
    },
    computed: {
      ...mapState('events', {
        isShowSearchDialog: state => state.isShowSearchDialog,
        searchQuery: state => state.searchQuery,
      })
    },
    methods: {
      ...mapActions('events', [
        'fetchEvents',
        'showSearchDialog'
      ]),
      ...mapActions('common', [
        'showEventDialog'
      ])
    },
    mounted: function() {
      this.$store.dispatch('common/setPageTitle', 'カラオケ一覧')
      this.fetchEvents()
    },
  }
</script>
