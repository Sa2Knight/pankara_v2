<template>
  <div class="song-aggregate">
    <v-layout row wrap>
      <v-flex xs12 sm6 md3>
        <song-aggregate-card title="月別歌唱回数">
          月ごとの歌唱回数棒グラフ
        </song-aggregate-card>
      </v-flex>
      <v-flex xs12 sm6 md3>
        <song-aggregate-card title="ユーザ別歌唱回数">
          歌ってるユーザの円グラフ
        </song-aggregate-card>
      </v-flex>
      <v-flex xs12 sm6 md3>
        <song-aggregate-card title="採点結果">
          採点タイプごとの点数
        </song-aggregate-card>
      </v-flex>
      <v-flex xs12 sm6 md3>
        <song-aggregate-card title="満足度レート">
          満足度のレート
        </song-aggregate-card>
      </v-flex>
    </v-layout>
  </div>
</template>

<style lang="scss">
.song-aggregate {
  .aggregate {
    height: 50%;
    border: 1px solid;
  }
}
</style>

<script>
  export default {
    components: {
      SongAggregateCard: require('./SongAggregateCard').default
    }
  }
</script>
