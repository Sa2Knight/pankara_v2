<!-- TODO: TheEventDialogにするべきで、partsではないだろ -->
<template>
  <div class="event-dialog">
    <v-dialog v-model="isShow" scrollable max-width="450px">
      <v-card class="event-detail">
        カラオケダイアログ！
      </v-card>
    </v-dialog>
  </div>
</template>

<style lang="scss" scoped>
.event-detail {
}
</style>

<script>
  // TODO: YoutubeDialogとmixinなりできる？
  import { mapState, mapActions } from 'vuex'
  const namespace = 'common'
  export default {
    data: function() {
      return {
        isShow: false
      }
    },
    computed: {
      ...mapState(namespace, {
        isShowEventDialog: state => state.isShowEventDialog,
        event: state => state.showingEvent,
      })
    },
    methods: {
      ...mapActions(namespace, [
        'hideEventDialog',
      ])
    },
    watch: {
      isShow: {
        handler: function(val) {
          if (this.isShowEventDialog && !this.isShow) {
            this.hideEventDialog()
          }
        },
      }
    },
    mounted: function() {
      this.isShow = this.isShowEventDialog
    },
  }
</script>
