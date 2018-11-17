<template>
  <div>
    <!-- サイドメニュー -->
    <v-navigation-drawer v-model="isShowNavigation" app>
      <v-list>
        <v-list-tile>
          <v-list-tile-action>
            <v-icon>fas fa-home</v-icon>
          </v-list-tile-action>
          <v-list-tile-title>トップ</v-list-tile-title>
        </v-list-tile>
        <v-list-group
          prepend-icon="fa-database"
          no-action
        >
          <v-list-tile slot="activator">
            <v-list-tile-title>記録を見る</v-list-tile-title>
          </v-list-tile>

          <router-link tag="div" :to="eventsPath">
            <v-list-tile>
                <v-list-tile-title>カラオケ一覧</v-list-tile-title>
              <v-list-tile-action>
                  <v-icon>fa-microphone</v-icon>
              </v-list-tile-action>
            </v-list-tile>
          </router-link>

          <v-list-tile>
            <v-list-tile-title>歌唱履歴</v-list-tile-title>
            <v-list-tile-action>
              <v-icon>fa-list-ol</v-icon>
            </v-list-tile-action>
          </v-list-tile>

          <v-list-tile>
            <v-list-tile-title>楽曲一覧</v-list-tile-title>
            <v-list-tile-action>
              <v-icon>fa-music</v-icon>
            </v-list-tile-action>
          </v-list-tile>

          <v-list-tile>
            <v-list-tile-title>アーティスト一覧</v-list-tile-title>
            <v-list-tile-action>
              <v-icon>fa-users</v-icon>
            </v-list-tile-action>
          </v-list-tile>
        </v-list-group>
        <v-list-group
          prepend-icon="fa-plus"
          no-action
        >
          <v-list-tile slot="activator">
            <v-list-tile-title>記録をする</v-list-tile-title>
          </v-list-tile>

          <v-list-tile>
            <v-list-tile-title>カラオケ新規作成</v-list-tile-title>
            <v-list-tile-action>
              <v-icon>fa-microphone</v-icon>
            </v-list-tile-action>
          </v-list-tile>

          <v-list-tile>
            <v-list-tile-title>歌唱履歴を追加</v-list-tile-title>
            <v-list-tile-action>
              <v-icon>fa-list-ol</v-icon>
            </v-list-tile-action>
          </v-list-tile>
        </v-list-group>
        <v-list-tile>
          <v-list-tile-action>
            <v-icon>fas fa-cog</v-icon>
          </v-list-tile-action>
          <v-list-tile-title>設定</v-list-tile-title>
        </v-list-tile>
      </v-list>
    </v-navigation-drawer>

    <!-- ヘッダーツールバー -->
    <v-toolbar app>
      <v-toolbar-side-icon @click.stop="isShowNavigation = !isShowNavigation">
      </v-toolbar-side-icon>
      <v-toolbar-title>{{ pageTitle }}</v-toolbar-title>
      <v-spacer></v-spacer>
      <!-- ユーザメニュー or ログインボタン -->
      <v-toolbar-items>
        <v-menu v-if="currentUser" transition="slide-y-transition" bottom>
          <v-btn class="login-user-icon-outer" slot="activator" >
            <img :src="currentUser.image_url" >
          </v-btn>
          <v-list>
            <v-list-tile v-for="(item, i) in userMenu" :key="i" @click="">
              <v-list-tile-title>{{ item.label }}</v-list-tile-title>
            </v-list-tile>
          </v-list>
        </v-menu>
        <v-btn v-else flat @click="isShowLoginForm = true">ログイン</v-btn>
      </v-toolbar-items>
    </v-toolbar>

    <!-- コンテンツ -->
    <v-content>
      <v-container fluid>
        <router-view></router-view>
      </v-container>
    </v-content>

    <!-- ログインフォーム -->
    <v-dialog v-model="isShowLoginForm" max-width="500px">
      <login-form
        @submit="login"
        @close="isShowLoginForm = false"
      />
    </v-dialog>

    <!-- Youtubeプレイヤー -->
    <youtube-dialog v-if="isShowYoutubeDialog"/>

    <!-- 歌唱履歴詳細ダイアログ　-->
    <history-dialog v-if="isShowHistoryDialog"/>


    <!-- スナック -->
    <v-snackbar v-model="isShowSuccessSnack" top color="success">
      ログインに成功しました
      <v-btn dark flat @click.native="isShowSuccessSnack = false">閉じる</v-btn>
    </v-snackbar>

    <v-snackbar v-model="isShowFailedSnack" top color="error">
      ログインに失敗しました
    </v-snackbar>

    <!-- ローディングビュー-->
    <the-loading-view v-if="isLoading" />

  </div>
</template>

<style lang="scss" scoped>
.login-user-icon-outer {
  position: relative;
  img {
    position: absolute;
    max-width: 60%;
    border-radius: 50%;
  }
}
</style>

<script>
  import { mapState, mapActions } from 'vuex'
  import ROUTES from '../lib/routes'
  const namespace = 'common'

  export default {
    data: function() {
      return {
        userMenu: [
          { label: 'マイページ' },
          { label: 'ログアウト' }
        ],
        isShowNavigation: false,
        isShowLoginForm: false,
        isShowSuccessSnack: false,
        isShowFailedSnack: false,
      }
    },
    computed: {
      ...mapState(namespace, {
        currentUser: state => state.currentUser,
        pageTitle: state => state.pageTitle,
        isShowYoutubeDialog: state => state.isShowYoutubeDialog,
        isShowHistoryDialog: state => state.isShowHistoryDialog,
        isLoading: state => state.isLoading
      }),
      eventsPath: () => ROUTES.EVENTS_PATH(),
    },
    methods: {
      ...mapActions(namespace, [
        'loginByToken'
      ]),
      login (name, password) {
        this.$store.dispatch('common/login', { name, password })
          .then(() => {
            this.isShowSuccessSnack = true
            this.isShowFailedSnack = false
            this.isShowLoginForm = false
          })
          .catch((err) => {
            this.isShowFailedSnack = true
            this.isShowSuccessSnack = false
          })
      }
    },
    mounted() {
      // 初回描画時、ログイントークンを持っていたらログイン
      this.loginByToken()
    },
    components: {
      LoginForm: require('../component/parts/Common/LoginForm').default,
      YoutubeDialog: require('../component/parts/Common/YoutubeDialog').default,
      HistoryDialog: require('../component/parts/Common/HistoryDialog').default,
      TheLoadingView:  require('../component/parts/Common/TheLoadingView').default,
      VUserIcon: require('../component/common/VUserIcon').default
    },
  }
</script>
