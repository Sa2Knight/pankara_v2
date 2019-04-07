<template>
  <div>
    <v-box :label="event.title"><TheEventDetail /></v-box>
    <v-box label="参加メンバー"><TheEventMembers /></v-box>

    <!-- 更新ボタン -->
    <div class="buttons" v-if="event.can_edit">
      <v-btn @click="() => showEventDialog(event)"
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
  import TheEventDetail from '@component/page/event/the/TheEventDetail'
  import TheEventMembers from '@component/page/event/the/TheEventMembers'
  import VBox from '@component/common/VBox'

  export default {
    components: {
      TheEventDetail,
      TheEventMembers,
      VBox
    },
    computed: {
      ...mapState('event', [
        'event'
      ])
    },
    methods: {
      ...mapActions('common', [
        'showEventDialog'
      ])
    },
  }
</script>
