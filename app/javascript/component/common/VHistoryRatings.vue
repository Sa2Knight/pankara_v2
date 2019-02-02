<template>
  <div>
    <v-rating
      v-model="value"
      small
      :length="10"
    />
  </div>
</template>

<script>
  export default {
    data: function() {
      return {
        value: 0
      }
    },
    props: {
    }
  }
</script>
