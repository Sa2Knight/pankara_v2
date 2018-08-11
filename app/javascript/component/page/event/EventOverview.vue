<template>
  <div class="event-overview">
    <v-box :label="event_title"><event-detail /></v-box>
    <v-box label="参加メンバー"><event-members /></v-box>
  </div>
</template>

<style lang="scss">
.event-overview {
  .v-box {
    margin: 0.5em 0 0.5em 0;
  }
}
</style>

<script>
  import { mapState } from 'vuex'
  export default {
    computed: {
      ...mapState({
        event_title: state => state.event.event.title
      })
    },
    components: {
      EventDetail:  require('./EventDetail').default,
      EventMembers: require('./EventMembers').default,
      VBox: require('../../common/VBox').default,
    }
  }
</script>
