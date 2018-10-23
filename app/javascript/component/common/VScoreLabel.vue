<template>
  <div class="v-score-label">
    <div class="score" :class="isHighScore ? 'high-score' : 'low-score'">{{ roundedScore }}</div>
  </div>
</template>

<style lang="scss" scoped>
.v-score-label {
  display: inline-flex;
  justify-content: center;
  align-items: center;
  flex-flow: column wrap;
  vertical-align: top;
  width: 2em;
  height: 2em;
  color: #fff;
  .score {
    font-size: 1em;
  }
  .low-score {
    background: skyblue;
    border: 4px solid skyblue;
    border-radius: 50%;
  }
  .high-score {
    border: 4px solid pink;
    background: pink;
    border-radius: 50%;
  }
}
</style>

<script>
  import Util from '../../lib/util'
  export default {
    props: {
      score: {
        type: Number,
        required: true,
      },
      digit: {
        type: Number,
        required: false,
        default: 1,
      },
      highScoreBorder: {
        type: Number,
        required: false,
        default: 90
      }
    },
    computed: {
      roundedScore: function() {
        return Util.round(this.score,this.digit)
      },
      isHighScore: function() {
        return this.score >= this.highScoreBorder
      }
    }
  }
</script>
