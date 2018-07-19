<template>
 <div class="event-detail">
    <h1>久々のヒトカラ！</h1>
    <v-layout row wrap>
      <v-flex xs12 sm6>
        <div class="event-info">
          <div class="key">日付</div>
          <div class="value">2018/03/03</div>
        </div>
      </v-flex>
      <v-flex xs12 sm6>
        <div class="event-info">
          <div class="key">時間</div>
          <div class="value">3.5時間</div>
        </div>
      </v-flex>
      <v-flex xs12 sm6>
        <div class="event-info">
          <div class="key">お店</div>
          <div class="value">カラオケ館</div>
        </div>
      </v-flex>
      <v-flex xs12 sm6>
        <div class="event-info">
          <div class="key">店舗</div>
          <div class="value">盛岡点</div>
        </div>
      </v-flex>
      <v-flex xs12 sm6>
        <div class="event-info">
          <div class="key">機種</div>
          <div class="value">JOYSOUND MAX</div>
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
    },
    components: {
      VUserIcon: require('../../common/VUserIcon.vue').default
    }
  }
</script>
