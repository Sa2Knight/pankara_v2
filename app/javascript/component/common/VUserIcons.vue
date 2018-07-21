<template>
  <div class="v-user-icons">
    <v-layout wrap row justify-center>
      <span v-for="user in targets">
        <div class="user">
          <img :src="user.image_url">
          <div class="display-name" v-if="showDisplayName">
            {{ user.display_name }}
          </div>
        </div>
      </span>
    </v-layout>
  </div>
</template>

<style lang="scss">
  .v-user-icons {
    .user {
      text-align: center;
      margin-left: 5px;
      margin-right: 5px;
      img {
        max-height: 2em;
        border-radius: 50%;
      }
      .display-name {
        margin-top: -0.5em;
      }
    }
  }
</style>

<script>
  export default {
    computed: {
      targets: function() {
        if (this.users) {
          return this.users
        } else {
          return [this.user]
        }
      }
    },
    props: {
      // ユーザ一覧またはユーザ
      // 各ユーザはimage_url属性を持つことを期待する
      user: {
        type: Object
      },
      users: {
        type: Array
      },
      showDisplayName: {
        type: Boolean,
        required: false,
        default: false,
      },
    }
  }
</script>
