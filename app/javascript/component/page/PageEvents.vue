<template>
  <div app>
    <v-container v-scroll="infiniteScroll" fluid grid-list-md>
      <v-radio-group row v-model="search.target">
        <v-radio label="あなたの" value="mine" />
        <v-radio label="すべての" value="all" />
      </v-radio-group>
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
          <v-card hover class="mb-2">
            <v-card-title primary-title>
              <h3>{{ props.item.title }}</h3>
            </v-card-title>
            <v-divider />
            <v-list>
              <v-list-tile>
                <v-list-tile-content>メンバー</v-list-tile-content>
                <v-list-tile-content class="align-end">
                  <v-user-icons :users="props.item.members" />
                </v-list-tile-content>
              </v-list-tile>
              <v-list-tile>
                <v-list-tile-content>日付</v-list-tile-content>
                <v-list-tile-content class="align-end">{{ props.item.datetime }}</v-list-tile-content>
              </v-list-tile>
              <v-list-tile>
                <v-list-tile-content>時間</v-list-tile-content>
                <v-list-tile-content class="align-end">{{ props.item.plan }}</v-list-tile-content>
              </v-list-tile>
              <v-list-tile>
                <v-list-tile-content>お店</v-list-tile-content>
                <v-list-tile-content class="align-end">
                  <v-store-label :store="props.item.store" />
                </v-list-tile-content>
              </v-list-tile>
              <v-list-tile>
                <v-list-tile-content>機種</v-list-tile-content>
                <v-list-tile-content class="align-end">JOYSOUN MAX</v-list-tile-content>
              </v-list-tile>
              <v-list-tile>
                <v-list-tile-content>曲数</v-list-tile-content>
                <v-list-tile-content class="align-end">{{ props.item.history_size }}</v-list-tile-content>
              </v-list-tile>
            </v-list>
          </v-card>
        </v-flex>
      </v-data-iterator>
      <v-fab-transition>
        <v-btn
          :v-show="true"
          color="orange"
          dark
          small
          fixed
          bottom
          right
          fab
        >
          <v-icon>keyboard_arrow_up</v-icon>
        </v-btn>
      </v-fab-transition>
    </v-container>
  </div>
</template>

<script>
  import CONST from '../../lib/constants'
  import http  from '../../lib/http'
  import { scrollIsBottom } from '../../lib/util'
  export default {
    data: function() {
      return {
        headers: [
          { text: '日付', value: 'datetime' },
          { text: 'タイトル', value: 'title' },
          { text: '時間', value: 'plan' },
          { text: '歌唱数', value: 'history_size' }
        ],
        events: [],
        search: {
          target: 'mine'
        },
        pager: {
          total: 0,
          page: 1,
          per:  CONST.PER,
        },
        is_loading: false,
        all_loaded: false
      }
    },
    methods: {
      fetch: function() {
        const params = {
          page: this.pager.page,
          per:  this.pager.per,
          members: this.search.target == 'mine' ? [11] : null // ログインユーザに差し替え
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
      }
    },
    watch: {
      search: {
        handler: function() {
          this.pager.page= 1
          this.events = []
          this.fetch()
        },
        deep: true
      }
    },
    mounted: function() {
      this.fetch()
    },
    components: {
      VStoreLabel: require('../common/VStoreLabel').default,
      VUserIcons:  require('../common/VUserIcons').default,
    }
  }
</script>
