<template>
  <div>
    <v-layout row>
      <v-flex class="pr-3">
        <v-slider
          v-model="localValue"
          :max="7"
          :min="-7"
        >
          <template v-if="!readonly">
            <v-icon slot="prepend" color="blue" @click="decrement">
              fas fa-minus
            </v-icon>
            <v-icon slot="append" color="blue" @click="increment">
              fas fa-plus
            </v-icon>
          </template>
        </v-slider>
      </v-flex>
      <v-flex shrink style="width: 15px">
        <v-text-field
          v-model="localValue"
          class="mt-0"
          readonly
          hide-details
          single-line
          type="number"
        ></v-text-field>
      </v-flex>
    </v-layout>
  </div>
</template>

<script>
  import InputComponentMixin from '@mixin/InputComponentMixin'
  export default {
    mixins: [InputComponentMixin],
    props: {
      readonly: {
        type: Boolean,
        required: false,
        default: false
      }
    },
    methods: {
      increment() {
        this.localValue += 1
      },
      decrement() {
        this.localValue -= 1
      }
    },
    watch: {
      localValue: function(v) {
        if (v > 7) {
          this.localValue = 7
        } else if (v < -7) {
          this.localValue = -7
        }
      }
    }
  }
</script>
