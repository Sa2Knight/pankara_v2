<script>
  import { mapState } from 'vuex'
  import VueCharts from 'vue-chartjs'
  import { HorizontalBar } from 'vue-chartjs'
  export default {
    extends: HorizontalBar,

    computed: {
      ...mapState({
        data: state => state.song.song.graph.satisfactions
      })
    },
    mounted () {
      this.renderChart({
        labels: [10, 9, 8 ,7, 6, 5, 4, 3, 2, 1],
        datasets: [
          {
            backgroundColor: '#00A0E9',
            data: this.data.reverse()
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
