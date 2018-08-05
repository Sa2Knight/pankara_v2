<template>
  <v-card hover class="mb-2">
    <v-card-title primary-title>
      <h3 class="collapse">{{ event.title }}</h3>
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
      VUserIcons:  require('../../common/VUserIcons').default,
    }
  }
</script>
