<template>
  <div>
    <div v-if="event">
      <v-tabs icons-and-text fixed-tabs centered dark color="cyan">
        <!-- タブメニュー -->
        <v-tabs-slider color="yellow"></v-tabs-slider>
        <v-tab href="#overview">
          概要
          <v-icon>fas fa-clipboard-list</v-icon>
        </v-tab>
        <v-tab href="#members">
          メンバー
          <v-icon>fas fa-users</v-icon>
        </v-tab>
        <v-tab href="#histories">
          歌唱履歴
          <v-icon>fas fa-list-ol</v-icon>
        </v-tab>

        <!-- 概要 -->
        <v-tab-item id="overview">
          概要
        </v-tab-item>

        <!-- メンバー -->
        <v-tab-item id="members">
          メンバー
        </v-tab-item>

        <!-- 歌唱履歴一覧 -->
        <v-tab-item id="histories">
          <v-layout row wrap class="pb-5">
            <v-flex xs12 sm6 md6 lg4 v-for="(history, i) in event.histories">
              <history-card :history="history" />
              <v-divider />
            </v-flex>
          </v-layout>
        </v-tab-item>
      </v-tabs>

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
