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
  import { mapState, mapActions } from 'vuex'
  const namespace = 'events'

  export default {
    data: function() {
      return {
        title: '',
        wantOnlyMine: false
      }
    },
    computed: {
      ...mapState(namespace, {
        searchQuery: state => state.searchQuery
      })
    },
    methods: {
      ...mapActions(namespace, [
        'submitSearchDialog',
        'cancelSearchDialog',
        'fetchEvents',
      ]),
      init: function() {
        this.title = this.searchQuery.title
        this.wantOnlyMine = this.searchQuery.wantOnlyMine
      },
      submit: function() {
        this.submitSearchDialog({
          title: this.title,
          wantOnlyMine: this.wantOnlyMine
        })
        this.fetchEvents()
      },
      cancel: function() {
        this.cancelSearchDialog()
        this.init()
      }
    },
    mounted: function() {
      this.init()
    },
  }
</script>
