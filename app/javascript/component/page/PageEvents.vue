<template>
  <div>
    <v-container fluid grid-list-md>
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
          md3
          1g1
        >
          <v-card hover>
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
    </v-container>
  </div>
</template>

<script>
  import CONST from '../../lib/constants'
  import http from '../../lib/http'
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
        pager: {
          total: 0,
          page: 1,
          per:  CONST.PER,
        },
        is_loading: false
      }
    },
    methods: {
      fetch: function() {
        const params = {
          page: this.pager.page,
          per:  this.pager.per,
        }
        this.is_loading = true
        http.getEvents(params).then((response) => {
          this.events = response.data
          this.pager.total = Number(response.headers['total-count'])
          this.is_loading = false
        })
      },
    },
    mounted: function() {
      this.fetch()
    },
    components: {
      VStoreLabel: require('../common/VStoreLabel').default,
      VUserIcons:  require('../common/VUserIcons').default
    }
  }
</script>
