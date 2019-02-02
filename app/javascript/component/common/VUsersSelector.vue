<template>
  <div>
    <v-autocomplete
      v-model="value"
      :items="users"
      color="blue-grey lighten-2"
      :label="label"
      item-text="display_name"
      item-value="id"
      :multiple="multiple"
    >
      <template
        slot="selection"
        slot-scope="data"
      >
        <v-chip
          :selected="data.selected"
          :close="multiple"
          class="chip--select-multi"
          @input="remove(data.item)"
        >
          <v-avatar><img :src="data.item.image_url"></v-avatar>
          {{ data.item.display_name }}
        </v-chip>
      </template>
      <template
        slot="item"
        slot-scope="data"
      >
        <template v-if="typeof data.item !== 'object'">
          <v-list-tile-content v-text="data.item"></v-list-tile-content>
        </template>
        <template v-else>
          <v-list-tile-avatar>
            <img :src="data.item.image_url">
          </v-list-tile-avatar>
          <v-list-tile-content>
            <v-list-tile-title v-html="data.item.display_name"></v-list-tile-title>
          </v-list-tile-content>
        </template>
      </template>
    </v-autocomplete>
  </div>
</template>

<script>
  export default {
    data () {
      return {
        value: [],
        name: 'Midnight Crew',
      }
    },

    props: {
      label: {
        type: String,
        required: true
      },
      multiple: {
        type: Boolean,
        required: false,
        default: false
      },
      users: {
        type: Array,
        required: true
      }
    },

    methods: {
      remove (item) {
        const index = this.value.indexOf(item.id)
        if (index >= 0) this.value.splice(index, 1)
      }
    },

    // スマートフォンでキーボードが表示されないように抑制
    mounted() {
      document.querySelector('.v-select__selections input').onfocus = function() {
        this.blur()
      }
    }
  }
</script>
