<template>
  <v-dialog v-model="isShow" :fullscreen="isMobile" max-width="450px">
    <v-card>
      <v-card-title class="headline grey lighten-2">
        カラオケ検索
      </v-card-title>
      <v-card-text>
        <v-container grid-list-md>
          <v-layout wrap>
            <v-flex xs12>
              <v-text-field v-model="title" label="タイトル" />
            </v-flex>
            <v-flex xs12 v-if="currentUser">
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
  </v-dialog>
</template>

<script>
  import DialogComponentMixin from '@mixin/DialogComponentMixin'
  import { mapState, mapActions } from 'vuex'

  export default {
    mixins: [DialogComponentMixin],
    data: function() {
      return {
        title: '',
        wantOnlyMine: false
      }
    },
    computed: {
      ...mapState('events', {
        searchQuery: state => state.searchQuery
      }),
      ...mapState('common', {
        currentUser: state => state.currentUser
      })
    },
    methods: {
      ...mapActions('events', [
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
          members: this.wantOnlyMine ? [this.currentUser.id] : null
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
