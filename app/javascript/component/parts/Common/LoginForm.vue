<template>
  <v-card>
    <v-card-title>
      <span class="headline">ログイン</span>
    </v-card-title>
    <v-card-text>
      <v-container grid-list-md>
        <v-form ref="form" v-model="valid">
          <v-layout wrap>
              <v-flex xs12>
                <v-text-field label="ユーザ名"
                  required
                  v-model="name"
                  :rules="nameRules"
                />
              </v-flex>
              <v-flex xs12>
                <v-text-field label="パスワード"
                  required
                  v-model="password"
                  :rules="passwordRules"
                  type="Password"
                />
              </v-flex>
              <v-flex xs6>
                <v-btn round @click="submit" class="pk-full-width" color="primary">
                  ログイン
                </v-btn>
              </v-flex>
              <v-flex xs6>
                <v-btn round @click="cancel" class="pk-full-width" color="primary">
                  キャンセル
                </v-btn>
              </v-flex>
          </v-layout>
        </v-form>
      </v-container>
    </v-card-text>
  </v-card>
</template>

<script>
  export default {
    data: function() {
      return {
        name: '',
        password: '',
        nameRules: [
          v => !!v || 'ユーザ名を入力してください'
        ],
        passwordRules: [
          v => !!v || 'パスワードを入力してください'
        ],
        valid: false,
      }
    },
    methods: {
      submit: function () {
        if (this.$refs.form.validate()) {
          this.$emit('submit', this.name, this.password)
        }
      },
      cancel: function() {
        this.$refs.form.reset()
        this.$emit('close')
      },
    },
  }
</script>
