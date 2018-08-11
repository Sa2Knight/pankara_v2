<template>
  <div class="event-overview">
    <v-box label="カラオケ情報">ここにカラオケ情報</v-box>
    <v-box label="参加メンバー"><event-members /></v-box>
  </div>
</template>

<script>
  import { mapState } from 'vuex'
  export default {
    components: {
      EventMembers: require('./EventMembers').default,
      VBox: require('../../common/VBox').default,
    }
  }
</script>
