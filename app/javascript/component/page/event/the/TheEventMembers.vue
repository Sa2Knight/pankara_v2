<template>
  <v-layout row wrap>
    <v-flex xs12 sm6 md4 v-for="member in members">
      <v-member-card :member="member"/>
    </v-flex>
  </v-layout>
</template>

<script>
  import { mapState, mapActions } from 'vuex'
  import VMemberCard from '@component/common/VMemberCard'

  export default {
    components: {
      VMemberCard
    },
    computed: {
      ...mapState('event', {
        members: state => state.event.members
      })
    },
  }
</script>
