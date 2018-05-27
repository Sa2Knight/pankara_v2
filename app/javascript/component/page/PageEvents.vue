<template>
  <div>
    <div class="title">カラオケ一覧</div>
    <section class="block">
      <b-field class="is-fullhd">
        <b-radio-button v-model="search.target"
          native-value="mine"
          type="is-success">
          <span>自分が参加したカラオケ</span>
        </b-radio-button>
        <b-radio-button v-model="search.target"
          native-value="all"
          type="is-info">
          <span>全てのカラオケ</span>
        </b-radio-button>
      </b-field>
      <b-dropdown v-model="search.sort_key">
        <button class="button is-prymary" slot="trigger">
          <span>{{ sortKeyLabel(search.sort_key) }}順</span>
           <b-icon icon="menu-down" />
        </button>
        <b-dropdown-item value="datetime">{{ sortKeyLabel('datetime') }}</b-dropdown-item>
        <b-dropdown-item value="title">{{ sortKeyLabel('title') }}</b-dropdown-item>
        <b-dropdown-item value="history_size">{{ sortKeyLabel('history_size') }}</b-dropdown-item>
      </b-dropdown>
    </section>
    <section>
      <b-table
        narrowed
        paginated
        backend-pagination
        :data="events"
        :total="pager.total"
        :per-page="pager.per"
        :current-page="pager.page"
        :loading="is_loading"
        @page-change="onPageChanged"
      >
        <template slot-scope="props">
          <b-table-column label="タイトル">
            {{ props.row.title  }}
          </b-table-column>
          <b-table-column label="日付">
            {{ props.row.datetime  }}
          </b-table-column>
          <b-table-column label="時間">
            {{ props.row.plan  }} 時間
          </b-table-column>
          <b-table-column label="お店">
            <v-store-label :store="props.row.store" />
          </b-table-column>
          <b-table-column label="曲数">
            {{ props.row.history_size  }}
          </b-table-column>
          <b-table-column label="メンバー">
            <v-user-icons :users="props.row.members" />
          </b-table-column>
        </template>
      </b-table>
    </section>
  </div>
</template>

<script>
  import CONST from '../../lib/constants'
  import http from '../../lib/http'
  export default {
    data: function() {
      return {
        events: [],
        pager: {
          total: 0,
          page: 1,
          per:  CONST.PER,
        },
        search: {
          target: 'mine',
          sort_key: 'datetime',
          keyword: '',
        },
        is_loading: false
      }
    },
    watch: {
      search: {
        handler: function() {
          this.pager.page = 1
          this.fetch()
        },
        deep: true
      }
    },
    methods: {
      fetch: function() {
        const params = {
          page: this.pager.page,
          per:  this.pager.per,
          members: this.search.target == 'mine' ? [11] : null, // TODO: ログイン中ユーザに差し替え
          sort_key: this.search.sort_key
        }
        this.is_loading = true
        http.getEvents(params).then((response) => {
          this.events = response.data
          this.pager.total = Number(response.headers['total-count'])
          this.is_loading = false
        })
      },
      onPageChanged: function(page) {
        this.pager.page = page
        this.fetch()
      },
      sortKeyLabel: function(sort_key) {
        return {
          'datetime': '日付',
          'title': 'タイトル',
          'history_size': '歌唱履歴数'
        }[sort_key]
      }
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
