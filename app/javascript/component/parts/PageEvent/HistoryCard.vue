<template>
  <div class="history-card">
    <v-container grid-list-md text-xs-center>
      <v-layout row>
        <v-flex xs4>
          <v-song-thumbnail :song="history.song" />
        </v-flex>
        <v-flex xs7>
          <h1>{{ history.song.name }}</h1>
          <h2>{{ history.song.artist.name }}</h2>
          <span>キー: {{ history.key }}</span>
          <span>満足度: {{ history.satisfaction }}</span>
          <span>得点: {{ history.score }}</span>
        </v-flex>
        <v-flex xs1>
          <v-user-icons :user="history.user" />
        </v-flex>
      </v-layout>
    </v-container>
  </div>
</template>

<style lang="scss">
  .history-card {
    h1 {
      font-size: 1.2em;
    }
    h2 {
      font-size: 1.1em;
    }
    .v-song-thumbnail {
      img {
        width: 100%;
        height: auto;
      }
    }
  }
</style>

<script>
  export default {
    data: function() {
      return {

      }
    },
    props: {
      history: {
        type: Object,
        required: true
      }
    },
    components: {
      VSongThumbnail: require('../../common/VSongThumbnail').default,
      VUserIcons: require('../../common/VUserIcons').default,
    }
  }
</script>
