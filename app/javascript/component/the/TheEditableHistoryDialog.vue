<template>
  <div class="the-editable-history-dialog">
    <v-dialog v-model="isShow" fullscreen max-width="500px">
      <v-card class="editable-history-dialog">
        <v-card-title class="headline grey lighten-2">
          {{ cardTitle }}
        </v-card-title>
        <v-card-text>
          <v-form class="history-form">
            <VUsersSelector label="歌った人" :multiple="false" :users="users" />

            <VAutocompleteTextField label="曲名" :states="songs" />

            <VAutocompleteTextField label="歌手名" :states="artists" />

             <v-subheader class="pl-0">キー設定</v-subheader>
            <VSongKeySlider />
          </v-form>
        </v-card-text>
      </v-card>
    </v-dialog>
  </div>
</template>

<style lang="scss" scoped>
.history-form {
  margin: 1.5em;
}
</style>

<script>
  import DialogComponentMixin from '@mixin/DialogComponentMixin'
  import VAutocompleteTextField from '@component/common/VAutocompleteTextField'
  import VUsersSelector from '@component/common/VUsersSelector'
  import VSongKeySlider from '@component/common/VSongKeySlider'
  import VSatisfactionRate from '@component/common/VSatisfactionRate'
  export default {
    mixins: [DialogComponentMixin],
    components: {
      VAutocompleteTextField,
      VUsersSelector,
      VSongKeySlider,
      VSatisfactionRate
    },
    data: function() {
      return {
        users: [
          { id: 1, display_name: 'ないと', image_url: '/user_icon/sa2knight.png' },
          { id: 2, display_name: 'へたれ', image_url: '/user_icon/hetare.png' },
          { id: 3, display_name: 'ちゃら', image_url: '/user_icon/unagipai.png' },
        ],
        songs: [
        ],
        artists: [
        ]
      }
    },
    computed: {
      cardTitle() {
        return '歌唱履歴作成'
      }
    }
  }
</script>
