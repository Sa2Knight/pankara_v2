<script>
  import VueCharts from 'vue-chartjs'
  import { Pie }   from 'vue-chartjs'
  export default {
    extends: Pie,

    mounted () {
      this.renderChart({
        labels: ['ないと', 'ともちん', 'へたれ', 'ちゃら'],
        datasets: [{
          backgroundColor: [
            '#ff6384',
            '#36a2eb',
            '#cc65fe',
            '#ffce56',
          ],
          data: Array.apply(null, new Array(4)).map(() => Math.floor(Math.random() * 20))
        }]
      }, {
        cutoutPercentage: 40,
      })
    }
  }
</script>
