<template>
  <div class="song-histories">
    <v-layout row wrap>
      <v-flex xs12 sm6 md4 lg3 v-for="history in histories">
        <song-history :history="history" />
      </v-flex>
    </v-layout>
  </div>
</template>

<style lang="scss">
.song-histories {
  padding: 15px;
}
</style>

<script>
  import { mapState } from 'vuex'
  export default {
    computed: {
      ...mapState({
        histories: state => state.song.histories
      })
    },
    components: {
      SongHistory: require('./SongHistory').default
    }
  }
</script>
