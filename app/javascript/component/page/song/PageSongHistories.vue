<template>
  <div class="page-song-histories">
    <v-layout row wrap>
      <v-flex xs12 sm6 md4 lg3 v-for="history in histories">
        <div @click="() => selectHistory(history.id)">
          <VHistoryCard :history="history" showEventTitle showDate/>
        </div>
      </v-flex>
    </v-layout>
  </div>
</template>

<style lang="scss">
</style>

<script>
  import { mapState, mapActions } from 'vuex'
  import VHistoryCard from '@component/common/VHistoryCard'

  export default {
    components: {
      VHistoryCard
    },
    computed: {
      ...mapState('song', {
        histories: state => state.histories,
        isSelectedHistory: state => !!state.selectedHistoryId,
      })
    },
    methods: {
      selectHistory: function(id) {
        this.$store.dispatch('common/showHistoryDialog', id)
      }
    }
  }
</script>
