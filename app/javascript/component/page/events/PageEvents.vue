<template>
  <div app>
    <v-container fluid grid-list-md>
      <!-- カラオケ一覧 -->
      <TheEventCards />

      <div class="buttons">
        <!-- 検索フォームボタン -->
        <v-btn v-show="true" @click="showSearchDialog"
               color="gray" class="elevation-12" fixed bottom right fab dark small>
          <v-icon>search</v-icon>
        </v-btn>

        <!-- 新規作成ボタン-->
        <v-btn v-show="isLogin" @click="() => showEventDialog(null)"
               color="pink" class="create-btn elevation-12" fixed bottom right fab dark small>
          <v-icon>add</v-icon>
        </v-btn>
      </div>
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

  export default {
    mixins: [PageCommonMixin],
    components: {
      TheEventCards,
      TheEventsSearchForm
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
