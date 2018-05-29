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
            <v-checkbox v-model="want_only_mine" label="あなたのカラオケのみ表示" />
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
  export default {
    data: function() {
      return {
        title: '',
        want_only_mine: false
      }
    },
    methods: {
      init: function() {
        this.title = this.value.title
        this.want_only_mine = this.value.want_only_mine
      },
      submit: function() {
        this.$emit('input', {
          title: this.title,
          want_only_mine: this.want_only_mine
        })
        this.$emit('submit')
        this.$emit('close')
      },
      cancel: function() {
        this.init()
        this.$emit('close')
      }
    },
    mounted: function() {
      this.init()
    },
    props: {
      value: {
        type: Object,
        required: true
      }
    }
  }
</script>
