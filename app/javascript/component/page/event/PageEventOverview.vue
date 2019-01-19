<template>
  <div>
    <v-box :label="event.title"><the-event-detail /></v-box>
    <v-box label="参加メンバー"><the-event-members /></v-box>

    <!-- 更新ボタン -->
    <!-- TODO: 更新権限ある場合のみ表示 -->
    <div class="buttons">
      <v-btn v-show="true" @click="() => showEventDialog(event)"
             color="gray" class="elevation-12" fixed bottom right fab dark>
        <v-icon>edit</v-icon>
      </v-btn>
    </div>
  </div>
</template>

<style lang="scss" scoped>
.v-box {
  margin: 0.5em 0 0.5em 0;
}
</style>

<script>
  import { mapState, mapActions } from 'vuex'
  const namespace = 'event'

  export default {
    computed: {
      ...mapState(namespace, [
        'event'
      ])
    },
    methods: {
      ...mapActions('common', [
        'showEventDialog'
      ])
    },
    components: {
      TheEventDetail:  require('./parts/TheEventDetail').default,
      TheEventMembers: require('./parts/TheEventMembers').default,
      VBox: require('../../common/VBox').default,
    }
  }
</script>
