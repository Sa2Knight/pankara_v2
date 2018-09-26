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
          <div @click="() => moveToDetail(props.item)">
            <v-event-card :event="props.item" />
          </div>
        </v-flex>
      </v-data-iterator>
    </v-pagination-wrapper>
  </div>
</template>

<script>
  import { mapState, mapActions } from 'vuex'
  import ROUTES from '../../../../lib/routes'
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
      moveToDetail: function(event) {
        this.$router.push(ROUTES.EVENT_PATH(event.id))
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
