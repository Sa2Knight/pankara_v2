<template>
  <div app>
    <v-container fluid grid-list-md>

      <!-- カラオケ一覧 -->
      <!-- TODO: コンポーネント切るべきだと思うよ -->
      <v-data-iterator :items="events" content-tag="v-layout"
                        row wrap disable-initial-sort hide-actions>
        <v-flex slot="item" slot-scope="props" xs12 sm6 md4 lg3 xl2 justify-space-between>
          <div @click="() => moveToDetail(props.item)">
            <v-event-card :event="props.item" />
          </div>
        </v-flex>
      </v-data-iterator>

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
  import ROUTES       from '../../../lib/routes'
  export default {
    computed: {
      ...mapState({
        events:      state => state.events.events,
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
      moveToDetail: function(event) {
        this.$router.push(ROUTES.EVENT_PATH(event.id))
      }
    },
    mounted: function() {
      this.$store.dispatch('setPageTitle', 'カラオケ一覧')
      this.fetch()
    },
    components: {
      VEventCard: require('./parts/VEventCard').default,
      TheEventsSearchForm: require('./parts/TheEventsSearchForm').default
    }
  }
</script>
