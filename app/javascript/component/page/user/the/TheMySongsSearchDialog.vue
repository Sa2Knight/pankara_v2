<!-- TODO: カラオケ検索ダイアログとmixinできない? -->
<template>
  <v-dialog v-model="isShow" :fullscreen="isMobile" max-width="500px">
    <v-card>
      <v-card-title class="headline grey lighten-2">
        持ち歌検索
      </v-card-title>
      <v-card-text>
        <v-container grid-list-md>
          <v-layout wrap>
            <v-flex xs12>
              <v-text-field v-model="name" label="曲名" />
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
  </v-dialog>
</template>

<script>
  import { mapState, mapActions } from 'vuex'
  import DialogComponentMixin from '@mixin/DialogComponentMixin'
  export default {
    mixins: [DialogComponentMixin],
    data: function() {
      return {
        name: '',
        artistName: ''
      }
    },
    computed: {
      ...mapState('user', [
        'mySongsSearchQuery'
      ]),
      ...mapState('common', [
        'currentUser'
      ])
    },
    methods: {
      ...mapActions('user', [
        'submitMySongsSearchDialog',
        'cancelMySongsSearchDialog',
        'fetchMySongs'
      ]),
      init() {
        this.name = this.mySongsSearchQuery.name
        this.artistName = this.mySongsSearchQuery.artistName
      },
      submit() {
        this.submitMySongsSearchDialog({
          name: this.name,
          artist_name: this.artistName
        })
        this.fetchMySongs(this.currentUser.id)
      },
      cancel() {
        this.init()
        this.cancelMySongsSearchDialog()
      }
    },
    mounted: function() {
      this.init()
    },
  }
</script>
