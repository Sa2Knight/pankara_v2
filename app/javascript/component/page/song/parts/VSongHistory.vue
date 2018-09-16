<template>
  <div class="v-song-history">
    <v-card hover class="md-2">
      <v-card-title primary-title class="header">
        <v-layout row wrap>
          <v-flex xs10>
            <h1 class="collapse"> {{ history.event.title }} </h1>
          </v-flex>
          <v-flex xs2>
            <div class="score">
              {{ history.score }}
            </div>
          </v-flex>
        </v-layout>
      </v-card-title>
      <v-divider />
      <v-history-comment
        :user="history.user"
        :comment="history.comment"
      />
      <v-divider />
      <div class="information">
        <div>
          <v-layout row wrap>
            <v-flex xs3>日付</v-flex>
            <v-flex xs9>
              {{ history.event.datetime }}
            </v-flex>
          </v-layout>
        </div>
        <div>
          <v-layout row wrap>
            <v-flex xs3>満足度</v-flex>
            <v-flex xs9>
              <v-stars :value="history.satisfaction" />
            </v-flex>
          </v-layout>
        </div>
        <div>
          <v-layout row wrap>
            <v-flex xs3>キー({{ history.key }})</v-flex>
            <v-flex xs9>
              <v-slider class="slider"
                readonly
                :value="history.key"
                :min="-7"
                :max="7"
                :step="1"
                :ticks-size="1"
                thumb-label
              ></v-slider>
            </v-flex>
          </v-layout>
        </div>
      </div>
    </v-card>
  </div>
</template>

<style lang="scss">
.v-song-history {
  width: 100%;
  height: auto;
  padding: 10px;
  .header {
    h1 {
      font-size: 1.1em;
    }
    .score {
      text-align: center;
    }
  }
  .information {
    padding: 1em 1.5em 0 1.5em;
    .slider {
      margin-top: -0.3em;
      padding: 0;
    }
    .event-date {
      text-align: right;
    }
    .v-input__slot {
      padding: 0;
    }
    .v-messages {
      min-height: 0;
    }
  }
}
</style>

<script>
  export default {
    props: {
      history: {
        required: true,
        type: Object,
      }
    },
    components: {
      VHistoryComment: require('../../../common/VHistoryComment').default,
      VStars: require('../../../common/VStars').default
    }
  }
</script>
