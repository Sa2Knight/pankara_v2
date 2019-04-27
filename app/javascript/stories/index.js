import Vue from 'vue';
import Vuetify from 'vuetify'
import { storiesOf } from '@storybook/vue';
import VPaginationWrapper from '@component/common/VPaginationWrapper'

Vue.use(Vuetify)

storiesOf('VPaginationWrapper', module)
  .add('候補あり', () => ({
    components: { VPaginationWrapper },
    methods: {
      changePage () {

      }
    },
    template: `
      <VPaginationWrapper :pageOrigin="5" :totalPages="20" :changePage="changePage" >
      </VPaginationWrapper>
    `
  }))
