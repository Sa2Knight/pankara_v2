<template>
 <div class="event-detail">
    <h1>{{ event.title }}</h1>
    <v-layout row wrap>
      <v-flex xs12 sm6>
        <div class="event-info">
          <div class="key">日付</div>
          <div class="value">{{ event.datetime }}</div>
        </div>
      </v-flex>
      <v-flex xs12 sm6>
        <div class="event-info">
          <div class="key">時間</div>
          <div class="value">{{ event.plan }}時間</div>
        </div>
      </v-flex>
      <v-flex xs12 sm6>
        <div class="event-info">
          <div class="key">お店</div>
          <div class="value">{{ event.store ? event.store.name : '未登録' }}</div>
        </div>
      </v-flex>
      <v-flex xs12 sm6>
        <div class="event-info">
          <div class="key">店舗</div>
          <div class="value">{{ event.store ? event.store.branch : '' }}</div>
        </div>
      </v-flex>
      <v-flex xs12 sm6>
        <div class="event-info">
          <div class="key">機種</div>
          <div class="value">{{ event.product ? event.product.full_name : '未登録' }}</div>
        </div>
      </v-flex>
    </v-layout>
  </div>
</template>

<style lang="scss">
.event-detail {
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
        plan: 0,
        storeName: '',
        storeBranch: '',
        product: null,
        isShowDatePickerModal: false,
        creator: { // DUMMY
          image_url: 'user_icon/sa2knight.png'
        }
      }
    },
    computed: {
      productMaster: () => CONST.PRODUCTS,
      ...mapState({
        event: store => store.event.event
      })
    },
    components: {
      VUserIcon: require('../../common/VUserIcon.vue').default
    }
  }
</script>
