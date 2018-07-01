<template>
  <div app>
    <v-container v-scroll="infiniteScroll" fluid grid-list-md>

      <!-- カラオケ一覧 -->
      <v-data-iterator :items="events" content-tag="v-layout"
                        row wrap disable-initial-sort hide-actions>
        <v-flex slot="item" slot-scope="props" xs12 sm6 md4 lg3 xl2 justify-space-between>
          <div @click="() => moveToDetail(props.item)">
            <event-card :event="props.item" />
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
    <v-dialog v-model="isShowSearchDialog" max-width="500px">
      <events-search-form/>
    </v-dialog>
  </div>
</template>

<script>
  import { mapState } from 'vuex'
  import CONST        from '../../../lib/constants'
  import ROUTES       from '../../../lib/routes'
  import { scrollIsBottom } from '../../../lib/util'
  export default {
    computed: {
      ...mapState({
        events:      state => state.events.events,
        isLoading:   state => state.events.isLoading,
        isAllLoaded: state => state.events.isLoading,
        isShowSearchDialog: state => state.events.isShowSearchDialog,
        searchQuery: state => state.events.searchQuery,
        pager:       state => state.events.pager,
      })
    },
    methods: {
      fetch: function() {
        this.$store.dispatch('fetchEvents')
      },
      infiniteScroll: function() {
        if (this.isLoading || this.isAllLoaded) {
          return
        }
        if (scrollIsBottom()) {
          this.$store.dispatch('pageIncrement')
          this.fetch()
        }
      },
      showSearchDialog: function() {
        this.$store.dispatch('showSearchDialog')
      },
      moveToDetail: function(event) {
        this.$router.push(ROUTES.EVENT_PATH(event.id))
      }
    },
    mounted: function() {
      this.fetch()
    },
    components: {
      EventCard:   require('./EventCard').default,
      EventsSearchForm: require('./EventsSearchForm').default
    }
  }
</script>
