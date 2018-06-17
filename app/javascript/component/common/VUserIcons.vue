<template>
  <div class="v-user-icons">
    <span v-for="user in targets">
      <img :src="user.image_url">
    </span>
  </div>
</template>

<style lang="scss">
  .v-user-icons {
    img {
      max-height: 2em;
      border-radius: 50%;
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
      }
    }
  }
</script>
