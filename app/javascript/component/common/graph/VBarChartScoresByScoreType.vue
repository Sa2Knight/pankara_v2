<script>
  import VueCharts from 'vue-chartjs'
  import { HorizontalBar } from 'vue-chartjs'
  export default {
    extends: HorizontalBar,

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
            data: Array.apply(null, new Array(5)).map(() => Math.floor(Math.random() * 30) + 70),
          },
          {
            label: '最高点',
            backgroundColor: '#79f879',
            data: Array.apply(null, new Array(5)).map(() => Math.floor(Math.random() * 30) + 70),
          }
        ],
      },
      {
        scales: {
          yAxes: [{
            ticks: {
              min: 70,
              max: 100
            }
          }]
        }
      },
      )
    }
  }
</script>
