<template>
  <div class="page-event">
    <div v-if="event && histories">
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
        <v-tab-item id="overview">
          <PageEventOverview />
        </v-tab-item>

        <!-- 歌唱履歴一覧 -->
        <!-- TODO: コンポーネント切ったほうが良いかも -->
        <v-tab-item id="histories">
          <v-layout row wrap class="pb-5">
            <v-flex xs12 sm12 md6 lg4 v-for="history in histories">
              <VHistoryCard :history="history" showSongName showArtistName />
              <v-divider />
            </v-flex>
          </v-layout>
          <!-- 追加ボタン -->
          <div class="buttons">
            <v-btn v-show="true" @click="() => {}"
                   color="gray" class="elevation-12" fixed bottom right fab dark>
              <v-icon>plus</v-icon>
            </v-btn>
          </div>
        </v-tab-item>
      </v-tabs>
    </div>
  </div>
</template>

<script>
  import { mapState, mapActions } from 'vuex'
  import PageCommonMixin from '@mixin/PageCommonMixin'
  import PageEventOverview from '@component/page/event/PageEventOverview'
  import VHistoryCard from '@component/common/VHistoryCard'

  export default {
    mixins: [PageCommonMixin],
    components: {
      PageEventOverview,
      VHistoryCard
    },
    computed: {
      ...mapState('event', {
        event: state => state.event,
        histories: state => state.histories
      }),
      id: function() {
        return this.$route.params.id
      },
    },
    methods: {
      ...mapActions('event', [
        'fetchEvent'
      ])
    },
    mounted: function() {
      this.fetchEvent(this.id).then()
    },
    watch: {
      event: function() {
        this.$store.dispatch('common/setPageTitle', this.event.title)
      }
    },
  }
</script>
