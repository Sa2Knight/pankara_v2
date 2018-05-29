<template>
  <div app>
    <v-container v-scroll="infiniteScroll" fluid grid-list-md>
      <v-data-iterator
        :items="events"
        content-tag="v-layout"
        disable-initial-sort
        row
        wrap
        hide-actions
      >
        <v-flex
          slot="item"
          slot-scope="props"
          xs12
          sm6
          md4
          lg3
          xl2
          justify-space-between
        >
          <event-card :event="props.item" />
        </v-flex>
      </v-data-iterator>
      <v-fab-transition>
        <v-btn
          :v-show="true"
          color="gray"
          @click="is_show_dialog = true"
          fixed
          class="elevation-12"
          bottom
          right
          fab
        >
          <v-icon>search</v-icon>
        </v-btn>
      </v-fab-transition>
    </v-container>

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
  import CONST from '../../lib/constants'
  import http  from '../../lib/http'
  import { scrollIsBottom } from '../../lib/util'
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
      }
    },
    mounted: function() {
      this.fetch()
    },
    components: {
      EventCard:   require('../parts/PageEvents/EventCard').default,
      EventsSearchForm: require('../parts/PageEvents/EventsSearchForm').default
    }
  }
</script>
