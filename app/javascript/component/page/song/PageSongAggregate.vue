<template>
  <div class="page-song-aggregate">
    <v-layout row wrap justify-center>
      <v-flex xs12 sm6 md3>
        <v-song-aggregate-card title="月別歌唱回数">
          <v-bar-chart-histories-by-month />
        </v-song-aggregate-card>
      </v-flex>
      <v-flex xs12 sm6 md3>
        <v-song-aggregate-card title="ユーザ別歌唱回数">
          <v-pie-chart-histories-by-user />
        </v-song-aggregate-card>
      </v-flex>
      <v-flex xs12 sm6 md3>
        <v-song-aggregate-card title="採点情報">
          <v-bar-chart-scores-by-score-type />
        </v-song-aggregate-card>
      </v-flex>
      <v-flex xs12 sm6 md3>
        <v-song-aggregate-card title="満足度レート">
          <v-bar-chart-satisfactions />
        </v-song-aggregate-card>
      </v-flex>
    </v-layout>
  </div>
</template>

<style lang="scss">
.page-song-aggregate {
  .aggregate {
    min-height: 50%;
    border: 1px solid;
  }
}
</style>

<script>
  export default {
    components: {
      VSongAggregateCard: require('./parts/VSongAggregateCard').default,
      VBarChartHistoriesByMonth:  require('../../common/graph/VBarChartHistoriesByMonth').default,
      VBarChartScoresByScoreType: require('../../common/graph/VBarChartScoresByScoreType').default,
      VBarChartSatisfactions:     require('../../common/graph/VBarChartSatisfactions').default,
      VPieChartHistoriesByUser:   require('../../common/graph/VPieChartHistoriesByUser').default
    }
  }
</script>
