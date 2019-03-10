<template>
 <div>
   <v-combobox
      v-model="value"
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
  export default {
    data: function() {
      return {
        value: '',
        intermediateValue: '',
      }
    },
    computed: {
      // 選択肢は1文字以上入力した場合のみ表示するため
      filteredStates: function() {
        if (!!this.intermediateValue) {
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
