<template>
  <v-card>
    <v-card-title class="headline grey lighten-2">
      持ち歌検索
    </v-card-title>
    <v-card-text>
      <v-container grid-list-md>
        <v-layout wrap>
          <v-flex xs12>
            <v-text-field v-model="songName" label="曲名" />
          </v-flex>
          <v-flex xs12>
            <v-text-field v-model="artistName" label="歌手名" />
          </v-flex>
          <v-flex xs6>
            <v-btn @click="submit" round class="pk-full-width" color="primary">
              検索
            </v-btn>
          </v-flex>
          <v-flex xs6>
            <v-btn @click="cancel" round class="pk-full-width" color="primary">
              キャンセル
            </v-btn>
          </v-flex>
        </v-layout>
      </v-container>
    </v-card-text>
  </v-card>
</template>

<script>
  import { mapState, mapActions } from 'vuex'
  const namespace = 'users'

  export default {
    data: function() {
      return {
        songName: '',
        artistName: ''
      }
    },
    computed: {
    },
    methods: {
      submit() {
      },
      cancel() {
      }
    },
    mounted: function() {
    },
  }
</script>
