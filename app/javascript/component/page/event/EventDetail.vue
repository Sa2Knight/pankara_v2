<template>
  <div class="event-detail">
    <div class="box">
      <div class="label center">
        <span>参加メンバー</span>
      </div>
      <div class="members center">
        <event-members />
      </div>
    </div>
  </div>
</template>

<style lang="scss">
.event-detail {
  .box {
    border: 1px solid;
    border-color: #ddd;
    .label {
      padding: 10px;
      background-color: #eee;
    }
    .members {
      margin-top: 5px;
      margin-bottom: 5px;
    }
  }
}
</style>

<script>
  import CONST from '../../../lib/constants'
  import { mapState } from 'vuex'
  export default {
    data: function() {
      return {
        title: '2018/03/03のカラオケ',
        date: '',
        isShowDatePickerModal: false,
        creator: { // DUMMY
          image_url: 'user_icon/sa2knight.png'
        }
      }
    },
    computed: {
      users: function() {
        return this.event.members.map((member) => member.user)
      },
      ...mapState({
        event: store => store.event.event
      })
    },
    components: {
      EventMembers: require('./EventMembers').default
    }
  }
</script>
