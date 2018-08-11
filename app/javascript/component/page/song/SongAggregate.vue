<template>
  <div class="song-aggregate">
    <v-layout row wrap>
      <v-flex xs12 sm6 md3>
        <song-aggregate-card title="月別歌唱回数">
          <v-bar-chart-histories-by-month />
        </song-aggregate-card>
      </v-flex>
      <v-flex xs12 sm6 md3>
        <song-aggregate-card title="ユーザ別歌唱回数">
          <v-pie-chart-histories-by-user />
        </song-aggregate-card>
      </v-flex>
      <v-flex xs12 sm6 md3>
        <song-aggregate-card title="採点結果">
          採点タイプごとの点数
        </song-aggregate-card>
      </v-flex>
      <v-flex xs12 sm6 md3>
        <song-aggregate-card title="満足度レート">
          <v-bar-chart-satisfactions />
        </song-aggregate-card>
      </v-flex>
    </v-layout>
  </div>
</template>

<style lang="scss">
.song-aggregate {
  .aggregate {
    min-height: 50%;
    border: 1px solid;
  }
}
</style>

<script>
  export default {
    components: {
      SongAggregateCard: require('./SongAggregateCard').default,
      VBarChartHistoriesByMonth: require('../../common/graph/VBarChartHistoriesByMonth').default,
      VBarChartSatisfactions:    require('../../common/graph/VBarChartSatisfactions').default,
      VPieChartHistoriesByUser:  require('../../common/graph/VPieChartHistoriesByUser').default
    }
  }
</script>
