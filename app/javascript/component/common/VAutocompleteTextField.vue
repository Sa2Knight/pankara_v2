<template>
 <div>
   <v-combobox
      v-model="value"
      v-on:update:searchInput="(v) => value = v"
      :search-input.sync="intermediateValue"
      :items="filteredStates"
      :readonly="false"
      :label="label"
      hide-no-data
      clearable
    >
      <v-slide-x-reverse-transition
        slot="append-outer"
        mode="out-in"
      >
        <v-icon
          color="success"
          key="icon-true"
          v-text="'mdi-check-outline'"
        ></v-icon>
      </v-slide-x-reverse-transition>
    </v-combobox>
 </div>
</template>

<script>
  import InputComponentMixin from '@mixin/InputComponentMixin'
  export default {
    mixins: [InputComponentMixin],
    data: function() {
      return {
        value: '',
        intermediateValue: '',
      }
    },
    computed: {
      // 選択肢は2文字から表示
      filteredStates: function() {
        if (this.intermediateValue && this.intermediateValue.length >= 2) {
          return this.states
        } else {
          return []
        }
      }
    },
    props: {
      label: {
        type: String,
        required: true
      },
      states: {
        type: Array,
        required: false,
        default: []
      },
    }
  }
</script>
