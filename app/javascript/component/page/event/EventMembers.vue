<template>
  <div class="event-members">
    <v-layout row wrap>
      <v-flex xs12 sm6 md4 v-for="member in members">
        <member-card :member="member"/>
      </v-flex>
    </v-layout>
  </div>
</template>

<script>
  import { mapState, mapActions } from 'vuex'
  const namespace = 'event'

  export default {
    computed: {
      ...mapState(namespace, {
        members: state => state.event.members
      })
    },
    components: {
      MemberCard: require('./MemberCard').default
    },
  }
</script>
