<template>
  <div class="v-pagination-wrapper">
    <div class="pager" v-if="hasMultiPage">
      <v-pagination
        v-model="page"
        :length="totalPages"
        @input="changePage"
      />
    </div>
    <slot />
    <div class="pager" v-if="hasMultiPage">
      <v-pagination
        v-model="page"
        :length="totalPages"
        @input="changePage"
      />
    </div>
  </div>
</template>

<style lang="scss">
.v-pagination-wrapper {
  .pager {
    text-align: center;
    padding-top: 1em;
    padding-bottom: 1em;
  }
  padding-bottom: 3em;
}
</style>

<script>
  export default {
    data: function() {
      return {
        page: 1
      }
    },
    props: {
      pageOrigin: {
        required: false,
        type: Number,
        default: 1
      },
      totalPages: {
        required: false,
        type: Number,
        default: 0,
      },
      changePage: {
        required: true,
        type: Function,
      }
    },
    computed: {
      hasMultiPage: function() {
        return this.totalPages > 1
      }
    },
    methods: {
    },
    watch: {
      pageOrigin: {
        handler: function() { this.page = this.pageOrigin },
        immediate: true
      }
    }
  }
</script>
