<!-- Note: maskの都合上、99.99点までしか入力できない
           100点を入力したい状況が生まれ次第なんとかする
-->
<template>
  <v-layout>
    <v-flex xs8>
      <VScoreTypeSelector v-model="scoreType" />
    </v-flex>
    <v-flex xs4>
      <v-text-field v-model="score"
        suffix="点"
        mask="##.##"
        return-masked-value
        clearable
        :disabled="isUnselectedScoreType"
       />
    </v-flex>
  </v-layout>
</template>

<script>
  // オブジェクトを戻すので、InputComponentMixinは使わずに自前実装する
  // TODO: これでコンポーネントの単体テスト書きたい
  import VScoreTypeSelector from '@component/common/VScoreTypeSelector'
  export default {
    data: function() {
      return {
        scoreType: 0,
        score: null,
      }
    },
    components: {
      VScoreTypeSelector
    },
    props: {
      value: {
        type: Object,
        required: false,
        default: function() {
          return {
            scoreType: 0,
            score: null,
          }
        },
        validator: function (v) {
          return v.hasOwnProperty('scoreType') && v.hasOwnProperty('score')
        }
      }
    },
    methods: {
      emit: function() {
        this.$emit('input', {
          scoreType: this.scoreType,
          score: this.score
        })
      }
    },
    computed: {
      isUnselectedScoreType: function() {
        return !this.scoreType
      },
      isInvalidScore: function() {
        if (this.score === null) return false

        const numberdScore = Number(this.score)
        return this.score === '' || isNaN(numberdScore) || numberdScore < 0 || numberdScore > 100.0
      },
    },
    watch: {
      scoreType: function() {
        if (this.isUnselectedScoreType) {
          this.score = null
        }
        this.emit()
      },
      score: function() {
        if (this.isInvalidScore) {
          this.score = null
        }
        this.emit()
      },
      value: function() {
        this.scoreType = this.value.scoreType,
        this.score = this.value.score
      }
    },
  }
</script>
