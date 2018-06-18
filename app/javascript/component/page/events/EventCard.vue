<template>
  <v-card hover class="mb-2">
    <v-card-title primary-title>
      <h3>{{ event.title }}</h3>
    </v-card-title>
    <v-divider />
    <v-list>
      <v-list-tile>
        <v-list-tile-content>メンバー</v-list-tile-content>
        <v-list-tile-content class="align-end">
          <v-user-icons :users="event.members" />
        </v-list-tile-content>
      </v-list-tile>
      <v-list-tile>
        <v-list-tile-content>日付</v-list-tile-content>
        <v-list-tile-content class="align-end">{{ event.datetime }}</v-list-tile-content>
      </v-list-tile>
      <v-list-tile>
        <v-list-tile-content>時間</v-list-tile-content>
        <v-list-tile-content class="align-end">{{ event.plan }}</v-list-tile-content>
      </v-list-tile>
      <v-list-tile>
        <v-list-tile-content>お店</v-list-tile-content>
        <v-list-tile-content class="align-end">
          <v-store-label :store="event.store" />
        </v-list-tile-content>
      </v-list-tile>
      <v-list-tile>
        <v-list-tile-content>機種</v-list-tile-content>
        <v-list-tile-content class="align-end">JOYSOUN MAX</v-list-tile-content>
      </v-list-tile>
      <v-list-tile>
        <v-list-tile-content>曲数</v-list-tile-content>
        <v-list-tile-content class="align-end">{{ event.history_size }}</v-list-tile-content>
      </v-list-tile>
    </v-list>
  </v-card>
</template>

<script>
  export default {
    props: {
      event: {
        type: Object,
        required: true
      }
    },
    components: {
      VStoreLabel: require('../../common/VStoreLabel').default,
      VUserIcons:  require('../../common/VUserIcons').default,
    }
  }
</script>
