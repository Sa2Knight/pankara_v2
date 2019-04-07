<template>
  <v-card hover class="mb-2">
    <v-card-title primary-title>
      <v-layout justify-space-between>
        <h3 class="collapse">{{ event.title }}</h3>
        <VUserIcons :users="event.members" />
      </v-layout>
    </v-card-title>
    <v-divider />
    <v-list>
      <v-list-tile>
        <v-list-tile-content>日付</v-list-tile-content>
        <v-list-tile-content class="align-end">{{ event.date }}</v-list-tile-content>
      </v-list-tile>
      <v-list-tile>
        <v-list-tile-content>曲数</v-list-tile-content>
        <v-list-tile-content class="align-end">{{ event.history_size }}</v-list-tile-content>
      </v-list-tile>
    </v-list>
  </v-card>
</template>

<script>
  import VUserIcons from '@component/common/VUserIcons'
  export default {
    components: {
      VUserIcons
    },
    props: {
      event: {
        type: Object,
        required: true
      }
    },
  }
</script>
