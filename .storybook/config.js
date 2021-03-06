import { configure } from '@storybook/vue';
import Vue from 'vue'
import Vuetify from 'vuetify'

Vue.use(Vuetify)

function loadStories() {
  require('../app/javascript/stories/index.js');
}

configure(loadStories, module);
