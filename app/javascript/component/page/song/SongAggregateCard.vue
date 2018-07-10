<template>
  <div class="song-aggregate-card">
    <v-card hover class="md-2">
      <v-card-title prymary-title class="header">
        <h1>{{ title }}</h1>
      </v-card-title>
      <v-divider />
      <div class="aggregate-body">
        <slot />
      </div>
    </v-card>
  </div>
</template>

<style lang="scss">
.song-aggregate-card {
  margin: 1em;
  height: 50vh;
  h1 {
    font-size: 1.1em;
  }
  .v-card {
    height: 100%;
  }
}
</style>

<script>
  export default {
    props: {
      title: {
        type: String,
        required: true,
      },
    },
  }
</script>
