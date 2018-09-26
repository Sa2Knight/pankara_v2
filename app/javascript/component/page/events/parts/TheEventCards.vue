<template>
  <div class="the-event-cards" v-show="events">
    <v-pagination-wrapper
      :pageOrigin="pageOrigin"
      :totalPages="totalPages"
      :changePage="changePage"
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
  import { mapState } from 'vuex'
  import ROUTES from '../../../../lib/routes'
  export default {
    computed: {
      ...mapState({
        events: store => store.events.events,
        pageOrigin: store => store.events.pager.page,
        totalPages: store => store.events.pager.totalPages,
      })
    },
    methods: {
      moveToDetail: function(event) {
        this.$router.push(ROUTES.EVENT_PATH(event.id))
      },
      changePage: function(page) {
        this.$store.dispatch('changePage', page)
        this.$store.dispatch('fetchEvents')
      }
    },
    components: {
      VPaginationWrapper: require('../../../common/VPaginationWrapper').default,
      VEventCard: require('./VEventCard').default
    }
  }
</script>
