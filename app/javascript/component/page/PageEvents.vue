<template>
  <div>
    <div class="title">カラオケ一覧</div>
    <section>
      <b-field>
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
    </section>
    <section>
      <b-table
        narrowed
        paginated
        pagination-simple
        backend-pagination
        :data="events"
        :total="pager.total"
        :per-page="pager.per"
        :current-page="pager.page"
        :loading="isLoading"
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
          keyword: '',
        },
        isLoading: false
      }
    },
    watch: {
      "search.target": function() {
        this.pager.page = 1
        this.fetch()
      }
    },
    methods: {
      fetch: function() {
        const params = {
          page: this.pager.page,
          per:  this.pager.per,
          members: this.search.target == 'mine' ? [11] : null // TODO: ログイン中ユーザに差し替え
        }
        this.isLoading = true
        http.getEvents(params).then((response) => {
          this.events = response.data
          this.pager.total = Number(response.headers['total-count'])
          this.isLoading = false
        })
      },
      onPageChanged: function(page) {
        this.pager.page = page
        this.fetch()
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
