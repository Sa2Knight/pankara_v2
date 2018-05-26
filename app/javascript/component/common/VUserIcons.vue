<template>
  <div>
    <span v-for="user in users">
      <img :src="user.image_url">
    </span>
  </div>
</template>

<style lang="scss">
  img {
    max-height: 2em;
    border-radius: 50%;
  }
</style>

<script>
  export default {
    props: {
      // ユーザ一覧
      // 各ユーザはimage_url属性を持つことを期待する
      users: {
        type: Array,
        required: true
      }
    }
  }
</script>
