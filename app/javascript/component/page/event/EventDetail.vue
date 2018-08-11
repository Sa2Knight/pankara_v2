<template>
  <div class="event-detail">
    <v-layout row wrap>
      <v-flex xs6 lg2>
        <v-simple-information header="日付">
          {{ event.datetime }}
        </v-simple-information>
      </v-flex>
      <v-flex xs6 lg2>
        <v-simple-information header="機種">
          {{ event.product }}
        </v-simple-information>
      </v-flex>
      <v-flex xs6 lg2>
        <v-simple-information header="平均点">
          {{ average_score }}
        </v-simple-information>
      </v-flex>
      <v-flex xs6 lg2>
        <v-simple-information header="最高点">
          {{ max_score }}
        </v-simple-information>
      </v-flex>
      <v-flex xs6 lg2>
        <v-simple-information header="曲数">
          {{ event.history_size }} 曲
        </v-simple-information>
      </v-flex>
      <v-flex xs6 lg2>
        <v-simple-information header="満足度">
          {{ average_satisfaction }}
        </v-simple-information>
      </v-flex>
    </v-layout>
  </div>
</template>

<style lang="scss" scoped>
/* カラオケ基本情報にキレイに境界線入れるため*/
.event-detail {
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
}
</style>

<script>
  import { mapState } from 'vuex'
  export default {
    computed: {
      ...mapState({
        event: state => state.event.event
      }),
      owner: function() {
        return this.event.members[0].user
      },
      average_satisfaction: function() {
        if (this.event.average_satisfaction) {
          return this.event.average_satisfaction + '%'
        } else {
          return '記録なし'
        }
      },
      average_score: function() {
        if (this.event.average_score) {
          return this.event.average_score + '点'
        } else {
          return '未採点'
        }
      },
      max_score: function() {
        if (this.event.max_score) {
          return this.event.max_score + '点'
        } else {
          return '未採点'
        }
      },
    },
    components: {
      VSimpleInformation: require('../../common/VSimpleInformation').default
    },
  }
</script>
