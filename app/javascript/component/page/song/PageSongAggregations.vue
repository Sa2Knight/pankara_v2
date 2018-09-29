<template>
  <v-layout row wrap justify-center>
    <v-flex xs12 sm6 md3>
      <v-song-aggregate-card title="月別歌唱回数">
        <the-bar-chart-histories-by-month />
      </v-song-aggregate-card>
    </v-flex>
    <v-flex xs12 sm6 md3>
      <v-song-aggregate-card title="ユーザ別歌唱回数">
        <the-pie-chart-histories-by-user />
      </v-song-aggregate-card>
    </v-flex>
    <v-flex xs12 sm6 md3>
      <v-song-aggregate-card title="採点情報">
        <the-bar-chart-scores-by-score-type />
      </v-song-aggregate-card>
    </v-flex>
    <v-flex xs12 sm6 md3>
      <v-song-aggregate-card title="満足度レート">
        <the-bar-chart-satisfactions />
      </v-song-aggregate-card>
    </v-flex>
  </v-layout>
</template>

<style lang="scss" scoped>
.aggregate {
  min-height: 50%;
  border: 1px solid;
}
</style>

<script>
  export default {
    components: {
      VSongAggregateCard:
        require('./parts/VSongAggregateCard').default,
      TheBarChartHistoriesByMonth:
        require('./graphs/TheBarChartHistoriesByMonth').default,
      TheBarChartScoresByScoreType:
        require('./graphs/TheBarChartScoresByScoreType').default,
      TheBarChartSatisfactions:
        require('./graphs/TheBarChartSatisfactions').default,
      ThePieChartHistoriesByUser:
        require('./graphs/ThePieChartHistoriesByUser').default
    }
  }
</script>
