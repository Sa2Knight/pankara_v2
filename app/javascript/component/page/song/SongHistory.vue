<template>
  <div class="song-history">
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
      <div class="body">
        <v-layout row wrap>
          <v-flex xs3>
            <div class="user-icon">
              <v-user-icon :user="history.user" />
            </div>
          </v-flex>
          <v-flex xs9 class="comment-wrapper">
            <div class="comment arrow-box">
              {{ history.comment }}
            </div>
          </v-flex>
        </v-layout>
      </div>
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
.song-history {
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
  .body {
    padding: 0 0.5em 0 0.5em;
    .comment-wrapper {
      position: relative;
      .comment {
        position: absolute;
        top: 0;
        bottom: 0;
      }
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
      VUserIcon: require('../../common/VUserIcon').default,
      VStars: require('../../common/VStars').default
    }
  }
</script>
