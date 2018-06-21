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
      <v-fab-transition>
        <v-btn :v-show="true" @click="is_show_dialog = true"
               color="gray" class="elevation-12" fixed bottom right fab>
          <v-icon>search</v-icon>
        </v-btn>
      </v-fab-transition>
    </v-container>

    <!-- 検索フォームをダイアログで描画 -->
    <v-dialog v-model="is_show_dialog" max-width="500px">
      <events-search-form
        v-model="query"
        @submit="search"
        @close="is_show_dialog = false"
      />
    </v-dialog>
  </div>
</template>

<script>
  import CONST  from '../../../lib/constants'
  import ROUTES from '../../../lib/routes'
  import http   from '../../../lib/http'
  import { scrollIsBottom } from '../../../lib/util'
  export default {
    data: function() {
      return {
        events: [],
        query: {
          title: '',
          want_only_mine: false,
        },
        pager: {
          total: 0,
          page: 1,
          per:  CONST.PER,
        },
        all_loaded: false,
        is_loading: false,
        is_show_dialog: false
      }
    },
    methods: {
      fetch: function() {
        const params = {
          page:    this.pager.page,
          per:     this.pager.per,
          title:   this.query.title,
          members: this.query.want_only_mine ? [9] : null // ログインユーザに差し替え
        }
        this.is_loading = true
        http.getEvents(params).then((response) => {
          const fetched_events = response.data
          this.events = this.events.concat(fetched_events)
          this.is_loading = false
          this.all_loaded = fetched_events.length == 0
          this.infiniteScroll()
        })
      },
      infiniteScroll: function() {
        if (this.is_loading || this.all_loaded) {
          return
        }
        if (scrollIsBottom()) {
          this.pager.page += 1
          this.fetch()
        }
      },
      search: function() {
        this.is_show_dialog = false
        this.pager.page = 1
        this.events = []
        this.fetch()
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
