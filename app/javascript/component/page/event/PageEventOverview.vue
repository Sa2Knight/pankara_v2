<template>
  <div>
    <v-box :label="event_title"><the-event-detail /></v-box>
    <v-box label="参加メンバー"><the-event-members /></v-box>
  </div>
</template>

<style lang="scss" scoped>
.v-box {
  margin: 0.5em 0 0.5em 0;
}
</style>

<script>
  import { mapState, mapActions } from 'vuex'
  const namespace = 'event'

  export default {
    computed: {
      ...mapState(namespace, {
        event_title: state => state.event.title
      })
    },
    components: {
      TheEventDetail:  require('./parts/TheEventDetail').default,
      TheEventMembers: require('./parts/TheEventMembers').default,
      VBox: require('../../common/VBox').default,
    }
  }
</script>
