<template>
  <div app>
    <v-container fluid grid-list-md>
      <h1>歌唱履歴一覧予定地</h1>
    </v-container>
  </div>
</template>

<style lang="scss" scoped>
</style>

<script>
  import { mapState, mapActions } from 'vuex'
  import PageCommonMixin from '@mixin/PageCommonMixin'
  import CONST from '@lib/constants'
  const namespace = 'histories'

  export default {
    mixins: [PageCommonMixin],
    computed: {
      ...mapState(namespace, {
      })
    },
    methods: {
      ...mapActions(namespace, [
        'fetchHistories',
      ]),
      ...mapActions('common', [
      ])
    },
    mounted: function() {
      this.$store.dispatch('common/setPageTitle', '歌唱履歴一覧')
      this.fetchHistories(this.$route.query.user_id)
    },
  }
</script>
