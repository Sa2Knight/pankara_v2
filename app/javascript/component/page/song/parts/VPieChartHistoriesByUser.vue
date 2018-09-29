<script>
  import { mapState } from 'vuex'
  import VueCharts from 'vue-chartjs'
  import { Pie }   from 'vue-chartjs'
  export default {
    extends: Pie,

    computed: {
      ...mapState({
        labels: state => state.song.song.graph.histories_by_user.labels,
        data:   state => state.song.song.graph.histories_by_user.data,
      })
    },
    mounted () {
      this.renderChart({
        labels: this.labels,
        datasets: [{
          backgroundColor: [
            '#ff6384',
            '#36a2eb',
            '#cc65fe',
            '#ffce56',
          ],
          data: this.data
        }]
      }, {
        cutoutPercentage: 40,
      })
    }
  }
</script>
