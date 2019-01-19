<template>
  <div class="the-event-cards" v-show="events">
    <VPaginationWrapper
      :pageOrigin="pageOrigin"
      :totalPages="totalPages"
      :changePage="fetchWithPaging"
    >
      <v-data-iterator :items="events" content-tag="v-layout"
                        row wrap disable-initial-sort hide-actions>
        <v-flex slot="item" slot-scope="props" xs12 sm6 md4 lg3 xl2 justify-space-between>
          <a :href="getEventPath(props.item)">
            <VEventCard :event="props.item" />
          </a>
        </v-flex>
      </v-data-iterator>
    </VPaginationWrapper >
  </div>
</template>

<script>
  import { mapState, mapActions } from 'vuex'
  import { ROUTES } from '@lib/routes'
  import VPaginationWrapper from '@component/common/VPaginationWrapper'
  import VEventCard from '@component/common/VEventCard'

  export default {
    components: {
      VPaginationWrapper,
      VEventCard
    },
    computed: {
      ...mapState('events', {
        events: store => store.events,
        pageOrigin: store => store.pager.page,
        totalPages: store => store.pager.totalPages,
      })
    },
    methods: {
      ...mapActions('events', [
        'changePage',
        'fetchEvents',
      ]),
      getEventPath: function(event) {
        return this.$router.resolve({
          name: 'Event',
          params: {
            id: event.id
          }
        }).href
      },
      fetchWithPaging: function(page) {
        this.changePage(page)
        this.fetchEvents()
      }
    },
  }
</script>
