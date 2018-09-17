<template>
  <div class="the-event-cards" v-show="events">
    <div class="pager">
      <v-pagination
        v-model="page"
        :length="totalPages"
        @input="changePage"
      />
    </div>
    <v-data-iterator :items="events" content-tag="v-layout"
                      row wrap disable-initial-sort hide-actions>
      <v-flex slot="item" slot-scope="props" xs12 sm6 md4 lg3 xl2 justify-space-between>
        <div @click="() => moveToDetail(props.item)">
          <v-event-card :event="props.item" />
        </div>
      </v-flex>
    </v-data-iterator>
    <div class="pager">
      <v-pagination
        v-model="page"
        :length="totalPages"
        @input="changePage"
      />
    </div>
  </div>
</template>

<style lang="scss">
  .the-event-cards {
    .pager {
      text-align: center;
      padding-top: 1em;
      padding-bottom: 1em;
    }
    padding-bottom: 3em;
  }
</style>

<script>
  import { mapState } from 'vuex'
  import ROUTES from '../../../../lib/routes'
  export default {
    data: function() {
      return {
        page: 1
      }
    },
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
    watch: {
      pageOrigin: function() {
        this.page = this.pageOrigin
      }
    },
    mounted: function() {
      this.page = this.pageOrigin
    },
    components: {
      VEventCard: require('./VEventCard').default
    }
  }
</script>
