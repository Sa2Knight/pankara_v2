<template>
  <div app>
    <v-container fluid grid-list-md>
      <TheEventCards />
    </v-container>

    <!-- 検索フォームをダイアログで描画 -->
    <div v-if="isShowSearchDialog">
      <TheEventsSearchDialog />
    </div>

    <div class="buttons">
      <!-- 検索フォームボタン -->
      <v-btn v-show="true" @click="showSearchDialog"
             color="gray" class="elevation-12" fixed bottom right fab dark >
        <v-icon>search</v-icon>
      </v-btn>

      <!-- 新規作成ボタン-->
      <v-btn v-show="isLogin" @click="() => showEventDialog(null)"
             color="pink" class="create-btn elevation-12" fixed bottom right fab dark >
        <v-icon>add</v-icon>
      </v-btn>
    </div>

  </div>
</template>

<style lang="scss" scoped>
.buttons {
  button {
    bottom: 0.5em;
    &.create-btn {
      right: 80px;
    }
  }
}
</style>

<script>
  import { mapState, mapActions } from 'vuex'
  import PageCommonMixin from '@mixin/PageCommonMixin'
  import CONST from '@lib/constants'
  import TheEventCards from '@component/page/events/the/TheEventCards'
  import TheEventsSearchDialog from '@component/page/events/the/TheEventsSearchDialog'

  export default {
    mixins: [PageCommonMixin],
    components: {
      TheEventCards,
      TheEventsSearchDialog
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
