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
  import { mapState } from 'vuex'
  export default {
    computed: {
      ...mapState({
        members: state => state.event.event.members
      })
    },
    components: {
      MemberCard: require('./MemberCard').default
    },
  }
</script>
