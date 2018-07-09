<template>
  <div class="v-user-icon">
    <div class="icon-wrapper">
      <div class="icon-inner">
        <img :src="user.image_url">
        <div v-if="showDisplayName" class="display-name">
          {{ user.display_name }}
        </div>
      </div>
    </div>
  </div>
</template>

<style lang="scss">
.v-user-icon {
  .icon-wrapper {
    height: 100%;
    text-align: center;
    .icon-inner {
      margin-top: 25%;
      img {
        width: auto;
        height: 48px;
        border-radius: 50%;
      }
    }
  }
}
</style>

<script>
  export default {
    props: {
      user: {
        required: true,
        type: Object,
      },
      showDisplayName: {
        required: false,
        type: Boolean,
        default: true
      }
    }
  }
</script>
