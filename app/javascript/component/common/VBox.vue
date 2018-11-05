<template>
  <div class="v-box">
    <div class="label">
      <span v-if="label">{{ label }}</span>
      <slot name="header"></slot>
    </div>
    <div class="content">
      <slot></slot>
    </div>
  </div>
</template>

<style lang="scss" scoped>
.v-box {
  border: 1px solid;
  border-color: #ddd;
  .label {
    padding: 10px;
    background-color: #eee;
    text-align: center;
  }
}
</style>

<script>
  export default {
    props: {
      label: {
        type: String,
        required: false
      }
    }
  }
</script>
