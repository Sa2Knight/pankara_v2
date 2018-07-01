<template>
  <div class="page-event">
    <div v-if="event">
      <v-tabs icons-and-text fixed-tabs centered dark color="grey lighten-5">
        <!-- タブメニュー -->
        <v-tabs-slider color="#feffcd"></v-tabs-slider>
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
          <event-members />
        </v-tab-item>

        <!-- 歌唱履歴一覧 -->
        <!-- TODO: コンポーネント切ったほうが良いかも -->
        <v-tab-item id="histories">
          <v-layout row wrap class="pb-5">
            <v-flex xs12 sm6 md6 lg4 v-for="(history, i) in event.histories">
              <history-card :history="history" />
              <v-divider />
            </v-flex>
          </v-layout>
          <v-btn color="pink" class="elevation-20" fixed bottom right fab dark>
            <v-icon>add</v-icon>
          </v-btn>
        </v-tab-item>
      </v-tabs>

    </div>
  </div>
</template>

<style lang="scss">
.page-event {
  .tabs__item {
    color: black;
    .icon {
      color: black;
    }
  }
}
</style>

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
      HistoryCard:  require('./HistoryCard').default,
      EventMembers: require('./EventMembers').default
    }
  }
</script>
