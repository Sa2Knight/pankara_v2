<script>
  import VueCharts from 'vue-chartjs'
  import { HorizontalBar } from 'vue-chartjs'
  export default {
    extends: HorizontalBar,

    mounted () {
      this.renderChart({
        labels: [10, 9, 8 ,7, 6, 5, 4, 3, 2, 1],
        datasets: [
          {
            backgroundColor: '#00A0E9',
            data: Array.apply(null, new Array(10)).map(() => Math.floor(Math.random() * 7)),
          }
        ],
      },
      {
        legend: {
          display: false,
        },
      },
      )
    }
  }
</script>
