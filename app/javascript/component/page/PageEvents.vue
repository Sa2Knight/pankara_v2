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
      <v-card>
        <v-card-title>
          <span class="headline">カラオケ検索</span>
        </v-card-title>
        <v-card-text>
          <v-container grid-list-md>
            <v-layout wrap>
              <v-flex xs12>
                <v-text-field v-model="query.title" label="タイトル" />
              </v-flex>
              <v-flex xs12>
                <v-checkbox v-model="query.want_only_mine" label="あなたのカラオケのみ表示" />
              </v-flex>
              <v-flex xs6>
                <v-btn @click="search" round class="pk-full-width" color="primary">
                  検索
                </v-btn>
              </v-flex>
              <v-flex xs6>
                <v-btn round class="pk-full-width" color="primary">キャンセル</v-btn>
              </v-flex>
            </v-layout>
          </v-container>
        </v-card-text>
      </v-card>
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
          want_only_mine: false,
          title: '',
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
      VStoreLabel: require('../common/VStoreLabel').default,
      VUserIcons:  require('../common/VUserIcons').default,
    }
  }
</script>
