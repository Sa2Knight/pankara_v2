<template>
  <v-card>
    <v-card-title>
      <span class="headline">カラオケ検索</span>
    </v-card-title>
    <v-card-text>
      <v-container grid-list-md>
        <v-layout wrap>
          <v-flex xs12>
            <v-text-field v-model="title" label="タイトル" />
          </v-flex>
          <v-flex xs12>
            <v-checkbox v-model="wantOnlyMine" label="あなたのカラオケのみ表示" />
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
  import { mapState } from 'vuex'
  export default {
    data: function() {
      return {
        title: '',
        wantOnlyMine: false
      }
    },
    computed: {
      ...mapState({
        searchQuery: state => state.events.searchQuery
      })
    },
    methods: {
      init: function() {
        this.title = this.searchQuery.title
        this.wantOnlyMine = this.searchQuery.wantOnlyMine
      },
      submit: function() {
        this.$store.dispatch('submitSearchDialog', {
          title: this.title,
          wantOnlyMine: this.wantOnlyMine
        })
      },
      cancel: function() {
        this.$store.dispatch('cancelSearchDialog')
        this.init()
      }
    },
    mounted: function() {
      this.init()
    },
  }
</script>
