<!-- TODO: コンポーネント名が不適切 -->
<template>
  <div class="history-card" v-bind:class="{ selected: isMouseOver, 'elevation-12': isMouseOver }">
    <v-container @click="select" @mouseenter="enter" @mouseleave="leave" grid-list-md text-xs-center>
      <v-layout row>
        <v-flex xs4>
          <v-song-thumbnail :song="history.song" />
        </v-flex>
        <v-flex xs7>
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
    &.selected {
      background-color: #feffcd;
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
        max-width: 100%;
        max-height: 100%;
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
  import { mapState } from 'vuex'
  import ROUTES from '../../../lib/routes'
  export default {
    data: function() {
      return {
        isMouseOver: false
      }
    },
    props: {
      history: {
        type: Object,
        required: true
      }
    },
    computed: {
      isSelected: function() {
        return this.history.id == this.selectedHistoryId
      },
      ...mapState({
        selectedHistoryId: function(state) {
          if (state.common.showingHistory) {
            return state.common.showingHistory.id
          }
          return null;
        }
      })
    },
    methods: {
      // 特定の歌唱履歴を選択状態にする
      select: function() {
        this.$store.dispatch('showHistoryDialog', this.history.id)
      },
      enter: function() {
        this.isMouseOver = true
      },
      leave: function() {
        this.isMouseOver = false
      }
    },
    components: {
      VSongThumbnail: require('../../common/VSongThumbnail').default,
      VUserIcons: require('../../common/VUserIcons').default,
    }
  }
</script>
