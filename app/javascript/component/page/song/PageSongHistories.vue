<template>
  <div class="page-song-histories">
    <v-layout row wrap>
      <v-flex xs12 sm6 md4 lg3 v-for="history in histories">
        <div @click="() => selectHistory(history.id)">
          <v-song-history :history="history" />
        </div>
      </v-flex>
    </v-layout>
  </div>
</template>

<style lang="scss">
.page-song-histories {
  padding: 15px;
}
</style>

<script>
  import { mapState } from 'vuex'
  export default {
    computed: {
      ...mapState({
        histories: state => state.song.histories,
        isSelectedHistory: state => !!state.song.selectedHistoryId,
      })
    },
    components: {
      VSongHistory: require('./parts/VSongHistory').default
    },
    methods: {
      selectHistory: function(id) {
        this.$store.dispatch('showHistoryDialog', id)
      }
    }
  }
</script>
