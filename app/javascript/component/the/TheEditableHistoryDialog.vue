<template>
  <div class="the-editable-history-dialog">
    <v-dialog v-model="isShow" fullscreen hide-overlay scrollable max-width="450px">
      <v-card class="editable-history-dialog">
        <v-form class="history-form">
          <VUsersSelector label="歌った人" :multiple="false" :users="users" />

          <VAutocompleteTextField label="曲名" :states="songs" />

          <VAutocompleteTextField label="歌手名" :states="artists" />

           <v-subheader class="pl-0">キー設定</v-subheader>
          <VSongKeySlider />
        </v-form>
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
  import VAutocompleteTextField from '@component/common/VAutocompleteTextField'
  import VUsersSelector from '@component/common/VUsersSelector'
  import VSongKeySlider from '@component/common/VSongKeySlider'
  import VSatisfactionRate from '@component/common/VSatisfactionRate'
  export default {
    components: {
      VAutocompleteTextField,
      VUsersSelector,
      VSongKeySlider,
      VSatisfactionRate
    },
    data: function() {
      return {
        isShow: true,
        users: [
          { id: 1, display_name: 'ないと', image_url: '/user_icon/sa2knight.png' },
          { id: 2, display_name: 'へたれ', image_url: '/user_icon/hetare.png' },
          { id: 3, display_name: 'ちゃら', image_url: '/user_icon/unagipai.png' },
        ],
        songs: [
          '明日もし君が壊れても',
          'ロストマン',
          '林檎華憐歌',
          'Snow Halation',
          '地球最後の告白を',
          '世界に一つだけの花',
          'ハルジオン',
          'magnet',
          '金太の大冒険',
          '初音ミクの消失',
          '初音ミクの暴走',
        ],
        artists: [
          'BUMP OF CHICKEN',
          'ビートまりお',
          'SMAP',
          'TOKIO',
          '米津玄師',
          '大塚愛',
          '星野源',
          'イヤミ、おそ松、カラ松、チョロ松、一松、十四松、トド松'
        ]
      }
    },
    props: {
    }
  }
</script>
