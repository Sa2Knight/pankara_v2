<template>
  <div class="page-event">
    <div v-if="event">
      <v-tabs icons-and-text centered dark color="grey lighten-5">
        <v-tabs-slider color="blue"></v-tabs-slider>
        <!-- タブメニュー -->
        <v-tab href="#overview">
          概要
          <v-icon>fas fa-clipboard-list</v-icon>
        </v-tab>
        <v-tab href="#histories">
          歌唱記録
          <v-icon>fas fa-list-ol</v-icon>
        </v-tab>

        <!-- 概要 -->
        <v-tab-item id="overview"><event-overview /></v-tab-item>

        <!-- 歌唱履歴一覧 -->
        <!-- TODO: コンポーネント切ったほうが良いかも -->
        <v-tab-item id="histories">
          <v-layout row wrap class="pb-5">
            <v-flex xs12 sm6 md6 lg4 v-for="history in event.histories">
              <v-history-card :history="history" />
              <v-divider />
            </v-flex>
          </v-layout>
        </v-tab-item>
      </v-tabs>
    </div>
  </div>
</template>

<script>
  import { mapState, mapActions } from 'vuex'
  const namespace = 'event'

  export default {
    computed: {
      ...mapState(namespace, {
        event: state => state.event
      }),
      id: function() {
        return this.$route.params.id
      },
    },
    methods: {
      ...mapActions(namespace, [
        'fetchEvent'
      ])
    },
    mounted: function() {
      this.$store.dispatch('common/setPageTitle', 'カラオケ詳細')
      this.fetchEvent(this.id)
    },
    components: {
      EventOverview:  require('./EventOverview').default,
      VHistoryCard:  require('../../common/VHistoryCard').default,
    }
  }
</script>
