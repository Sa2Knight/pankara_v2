<!-- TODO: TheEventDialogにするべきで、partsではないだろ -->
<template>
  <div class="event-dialog">
    <v-dialog v-model="isShow" scrollable max-width="450px">
      <v-card class="event-detail">
        <v-card-title class="headline grey lighten-2">
          カラオケ新規登録
        </v-card-title>
        <v-card-text>
          <v-form>
            <v-text-field label="カラオケタイトル"
              v-model="title"
              :rules="titleRules"
            />
            <v-menu
              v-model="showingDatePicker"
              transition="scale-transition"
              offset-y
              full-width
            >
              <v-text-field
                slot="activator"
                v-model="date"
                label="日付"
                readonly
              />
              <v-date-picker
                v-model="date"
                @input="showingDatePicker = false"
                :max="datePickerMax"
                locale="ja"
                width="100%"
              />
            </v-menu>
          </v-form>
        </v-card-text>
        <v-divider></v-divider>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn round color="primary" @click="submit">
            登録
          </v-btn>
          <v-btn round color="primary" @click="hideEventDialog">
            キャンセル
          </v-btn>
        </v-card-actions>
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
  import moment from 'moment'
  const namespace = 'common'
  export default {
    data: function() {
      return {
        isShow: false,
        title: '',
        titleRules: [
          v => v.length <= 24 || 'タイトルは24文字以下で入力してください'
        ],
        date: null,
        showingDatePicker: false,
      }
    },
    computed: {
      ...mapState(namespace, {
        isShowEventDialog: state => state.isShowEventDialog,
        event: state => state.showingEvent,
      }),
      datePickerMax: () => {
        return moment().format('YYYY-MM-DD')
      }
    },
    methods: {
      ...mapActions(namespace, [
        'hideEventDialog',
      ]),
      ...mapActions('events', [
        'createEvent'
      ]),
      submit: function() {
        const params = {
          title: this.title,
          date: this.date,
          users: []
        }
        this.createEvent(params).then(() => {
          this.hideEventDialog()
        })
      }
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
