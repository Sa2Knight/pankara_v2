<template>
  <v-layout row wrap>
    <v-flex xs6 lg2>
      <VSimpleInformation header="日付">
        {{ event.date }}
      </VSimpleInformation>
    </v-flex>
    <v-flex xs6 lg2>
      <VSimpleInformation header="平均点">
        {{ average_score }}
      </VSimpleInformation>
    </v-flex>
    <v-flex xs6 lg2>
      <VSimpleInformation header="最高点">
        {{ max_score }}
      </VSimpleInformation>
    </v-flex>
    <v-flex xs6 lg2>
      <VSimpleInformation header="曲数">
        {{ event.history_size }} 曲
      </VSimpleInformation>
    </v-flex>
    <v-flex xs6 lg2>
      <VSimpleInformation header="満足度">
        {{ average_satisfaction }}
      </VSimpleInformation>
    </v-flex>
  </v-layout>
</template>

<style lang="scss" scoped>
/* カラオケ基本情報にキレイに境界線入れるため*/
@media (min-width: 0) {
  .flex:nth-child(even) {
    .v-simple-information {
      border-left: 1px solid #e6e6e6;
    }
  }
}
@media (min-width: 1264px) {
  .flex:nth-child(n+2):nth-last-child(n+2) {
    .v-simple-information {
      border-left: 1px solid #e6e6e6;
    }
  }
}
</style>

<script>
  import { mapState, mapActions } from 'vuex'
  import Util from '../../../../lib/util'
  import VSimpleInformation from '@component/common/VSimpleInformation'

  export default {
    components: {
      VSimpleInformation
    },
    computed: {
      ...mapState('event', {
        event: state => state.event
      }),
      owner: function() {
        return this.event.members[0].user
      },
      average_satisfaction: function() {
        if (this.event.average_satisfaction) {
          return Util.round(this.event.average_satisfaction, 2)
        } else {
          return '記録なし'
        }
      },
      average_score: function() {
        if (this.event.average_score) {
          return Util.round(this.event.average_score, 2) + '点'
        } else {
          return '未採点'
        }
      },
      max_score: function() {
        if (this.event.max_score) {
          return Util.round(this.event.max_score, 2) + '点'
        } else {
          return '未採点'
        }
      },
    },
  }
</script>
