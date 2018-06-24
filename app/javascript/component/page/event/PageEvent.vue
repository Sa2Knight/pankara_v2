<template>
  <div>
    <div v-if="event">
      <h1>歌唱履歴</h1>
      <!-- 歌唱履歴一覧 -->
      <v-layout row wrap class="pb-5">
        <v-flex xs12 sm6 md6 lg4 v-for="(history, i) in event.histories">
          <history-card :history="history" />
          <v-divider />
        </v-flex>
      </v-layout>

      <!-- 追加ボタン -->
      <v-fab-transition>
        <v-btn color="pink" class="elevation-20" fixed bottom right fab dark>
          <v-icon>add</v-icon>
        </v-btn>
      </v-fab-transition>
    </div>
  </div>
</template>

<script>
  import { mapState } from 'vuex'
  export default {
    methods: {
      fetch: function() {
        this.$store.dispatch('fetchEvent', this.id)
      },
    },
    computed: {
      id: function() {
        return this.$route.params.id
      },
      ...mapState({
        event: state => state.event.event
      })
    },
    mounted: function() {
      this.fetch()
    },
    components: {
      HistoryCard: require('./HistoryCard').default
    }
  }
</script>
