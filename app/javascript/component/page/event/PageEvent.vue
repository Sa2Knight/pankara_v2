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
  import http  from '../../../lib/http'
  export default {
    data: function() {
      return {
        event: null,
        selectedEvent: null,
      }
    },
    methods: {
      fetch: function() {
        http.getEvent(this.id).then((response) => {
          this.event = response.data
        })
      },
    },
    computed: {
      id: function() {
        return this.$route.params.id
      }
    },
    mounted: function() {
      this.fetch()
    },
    components: {
      HistoryCard: require('./HistoryCard').default
    }
  }
</script>
