<template>
  <div class="v-simple-information">
    <div class="head">{{ header }}:</div>
    <div class="body"><slot></slot></div>
  </div>
</template>

<style lang="scss">
.v-simple-information {
  position: relative;
  padding: 0.5em;
  border-bottom: 1px solid #e6e6e6;
  .head {
    float: left;
    font-weight: bold;
    margin-right: 1em;
    min-width: 4em;
  }
  .body {
    right: 0px;
  }
  &:after {
    clear: both;
  }
}
</style>

<script>
  export default {
    props: {
      header: {
        type: String,
        required: true
      },
    },
  }
</script>

