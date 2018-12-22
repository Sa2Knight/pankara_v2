<template>
  <div class="the-event-cards" v-show="events">
    <v-pagination-wrapper
      :pageOrigin="pageOrigin"
      :totalPages="totalPages"
      :changePage="fetchWithPaging"
    >
      <v-data-iterator :items="events" content-tag="v-layout"
                        row wrap disable-initial-sort hide-actions>
        <v-flex slot="item" slot-scope="props" xs12 sm6 md4 lg3 xl2 justify-space-between>
          <a :href="getEventPath(props.item)">
            <v-event-card :event="props.item" />
          </a>
        </v-flex>
      </v-data-iterator>
    </v-pagination-wrapper>
  </div>
</template>

<script>
  import { mapState, mapActions } from 'vuex'
  import { ROUTES } from '../../../../lib/routes'
  const namespace = 'events'

  export default {
    computed: {
      ...mapState(namespace, {
        events: store => store.events,
        pageOrigin: store => store.pager.page,
        totalPages: store => store.pager.totalPages,
      })
    },
    methods: {
      ...mapActions(namespace, [
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
    components: {
      VPaginationWrapper: require('../../../common/VPaginationWrapper').default,
      VEventCard: require('./VEventCard').default
    }
  }
</script>
