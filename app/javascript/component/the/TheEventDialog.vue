<template>
  <div class="the-event-dialog">
    <v-dialog v-model="isShow" :fullscreen="isMobile" max-width="450px">
      <v-card class="event-detail">
        <v-card-title class="headline grey lighten-2">
          {{ dialogTitle }}
        </v-card-title>
        <v-card-text>
          <v-form ref="form">
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
                :rules="dateRules"
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
</style>

<script>
  // TODO: YoutubeDialogとmixinなりできる？
  import { mapState, mapActions } from 'vuex'
  import moment from 'moment'
  import DialogComponentMixin from '@mixin/DialogComponentMixin'
  export default {
    mixins: [DialogComponentMixin],
    data: function() {
      return {
        isShow: false,
        title: '',
        date: moment().format('YYYY-MM-DD'),
        showingDatePicker: false,
        titleRules: [
          v => !!v || 'タイトルを入力してください',
          v => v.length <= 24 || 'タイトルは24文字以下で入力してください'
        ],
        dateRules: [
          v => !!v || '日付を入力してください'
        ],
      }
    },
    computed: {
      ...mapState('common', {
        isShowEventDialog: state => state.isShowEventDialog,
        event: state => state.showingEvent,
      }),
      isUpdateMode: function() {
        return !!this.event
      },
      datePickerMax: () => {
        return moment().format('YYYY-MM-DD')
      },
      dialogTitle: function() {
        return this.event ? 'カラオケ編集' : 'カラオケ新規登録'
      },
      requestParams: function() {
        return {
          title: this.title,
          date: this.date
        }
      }
    },
    methods: {
      ...mapActions('common', [
        'hideEventDialog',
      ]),
      ...mapActions('event', [
        'createEvent',
        'updateEvent'
      ]),
      submit: function() {
        if (!this.$refs.form.validate()) { return }

        if (this.isUpdateMode) {
          this.updateEvent({id: this.event.id, params: this.requestParams}).then(() => {
            this.hideEventDialog()
          })
        } else {
          this.createEvent(this.requestParams).then(() => {
            this.hideEventDialog()
          })
        }
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
      if (this.isUpdateMode) {
        this.title = this.event.title
        this.date = this.event.date
      }
      this.isShow = this.isShowEventDialog
    },
  }
</script>
