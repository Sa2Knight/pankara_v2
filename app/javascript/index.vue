<template>
  <div>
    <section>
      <b-notification type="is-warning">
        {{ hello }}
      </b-notification>
    </section>
  </div>
</template>

<script>
  export default {
    data: () => {
      return {
        hello: 'Hello!!Pankara!!'
      }
    }
  }
</script>
