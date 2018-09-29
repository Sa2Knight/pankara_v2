<template>
  <div class="page-song-aggregate">
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
      VSongAggregateCard:
        require('./parts/VSongAggregateCard').default,
      TheBarChartHistoriesByMonth:
        require('./parts/TheBarChartHistoriesByMonth').default,
      TheBarChartScoresByScoreType:
        require('./parts/TheBarChartScoresByScoreType').default,
      TheBarChartSatisfactions:
        require('./parts/TheBarChartSatisfactions').default,
      ThePieChartHistoriesByUser:
        require('./parts/ThePieChartHistoriesByUser').default
    }
  }
</script>
