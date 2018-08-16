<script>
  import { mapState } from 'vuex'
  import VueCharts from 'vue-chartjs'
  import { HorizontalBar } from 'vue-chartjs'
  export default {
    extends: HorizontalBar,

    computed: {
      ...mapState({
        data: state => state.song.song.graph.scores_by_score_type
      })
    },
    mounted () {
      this.renderChart({
        labels: [
          'JOY: 全国採点',
          'JOY: 分析採点',
          'DAM: ランバト',
          'DAM: 精密採点',
          'その他'
        ],
        datasets: [
          {
            label: '平均点',
            backgroundColor: '#f87979',
            data: this.data.avg,
          },
          {
            label: '最高点',
            backgroundColor: '#79f879',
            data: this.data.max,
          }
        ],
      },
      {
        scales: {
          xAxes: [{
            ticks: {
              min: 65,
              max: 100
            }
          }]
        }
      },
      )
    }
  }
</script>
