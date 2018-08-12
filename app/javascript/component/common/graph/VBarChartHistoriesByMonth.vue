<script>
  import { mapState } from 'vuex'
  import VueCharts from 'vue-chartjs'
  import { Bar } from 'vue-chartjs'
  export default {
    extends: Bar,

    computed: {
      ...mapState({
        data: state => state.song.song.graph.histories_by_month
      })
    },
    mounted () {
      this.renderChart({
        labels: [
          '01月',
          '02月',
          '03月',
          '04月',
          '05月',
          '07月',
          '08月',
          '09月',
          '10月',
          '11月',
          '12月',
        ],
        datasets: [
          {
            backgroundColor: '#f87979',
            data: this.data,
          }
        ],
      },
      {
        legend: {
          display: false,
        },
        scales: {
          yAxes: [{
            ticks: {
              min: 0,
              max: 10
            }
          }]
        }
      },
      )
    }
  }
</script>
