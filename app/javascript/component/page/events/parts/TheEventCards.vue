<template>
  <div class="the-event-cards" v-show="events">
    <v-data-iterator :items="events" content-tag="v-layout"
                      row wrap disable-initial-sort hide-actions>
      <v-flex slot="item" slot-scope="props" xs12 sm6 md4 lg3 xl2 justify-space-between>
        <div @click="() => moveToDetail(props.item)">
          <v-event-card :event="props.item" />
        </div>
      </v-flex>
    </v-data-iterator>
  </div>
</template>

<script>
  import { mapState } from 'vuex'
  import ROUTES from '../../../../lib/routes'
  export default {
    computed: {
      ...mapState({
        events: store => store.events.events
      })
    },
    methods: {
      moveToDetail: function(event) {
        this.$router.push(ROUTES.EVENT_PATH(event.id))
      }
    },
    components: {
      VEventCard: require('./VEventCard').default
    }
  }
</script>
