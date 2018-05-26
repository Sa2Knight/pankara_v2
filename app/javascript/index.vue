<template>
  <div>
    <div class="title">カラオケ一覧</div>
    <b-table
      narrowed
      paginated
      backend-pagination
      :data="events"
      :columns="columns"
      :total="pager.total"
      :per-page="pager.per"
      :page="pager.page"
      :loading="isLoading"
      @page-change="onPageChanged"
    />
  </div>
</template>

<script>
  import CONST from './lib/constants'
  import http from './lib/http'
  export default {
    data: function() {
      return {
        events: [],
        columns: [
          {
            field: 'datetime',
            label: '日付'
          },
          {
            field: 'title',
            label: 'タイトル'
          },
          {
            field: 'plan',
            label: '時間'
          },
          {
            field: 'history_size',
            label: '曲数'
          },
        ],
        pager: {
          total: 0,
          page: 1,
          per:  CONST.PER,
        },
        isLoading: false
      }
    },
    methods: {
      fetch: function() {
        const params = {
          page: this.pager.page,
          per:  this.pager.per
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
    }
  }
</script>
