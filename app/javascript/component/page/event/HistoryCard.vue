<template>
  <div class="history-card">
    <v-container grid-list-md text-xs-center>
      <v-layout row>
        <v-flex xs4>
          <v-song-thumbnail :song="history.song" />
        </v-flex>
        <v-flex xs7 @click="select">
          <p class="song-name collapse">{{ history.song.name }}</p>
          <p class="artist-name collapse">{{ history.song.artist.name }}</p>
          <span>キー: {{ history.key }}</span>
          <span>満足度: {{ history.satisfaction }}</span>
          <span>得点: {{ history.score }}</span>
        </v-flex>
        <v-flex xs1 class="right-column">
          <v-user-icons :user="history.user" />
        </v-flex>
      </v-layout>
    </v-container>
  </div>
</template>

<style lang="scss">
  .history-card {
    * {
      margin: 0;
      padding: 0;
    }
    p {
      font-weight: bold;
      &.song-name {
        font-size: 1.2em;
      }
      &.artist-name {
        font-size: 1.1em;
      }
    }
    .v-song-thumbnail {
      img {
        width: 100%;
        height: auto;
      }
    }
    .right-column {
      position: relative;
      .v-user-icons {
        position: absolute;
        right: 0;
        bottom: 0;
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
    methods: {
      select: function() {
        this.$store.dispatch('selectHistory', this.history.id)
      }
    },
    components: {
      VSongThumbnail: require('../../common/VSongThumbnail').default,
      VUserIcons: require('../../common/VUserIcons').default,
    }
  }
</script>
