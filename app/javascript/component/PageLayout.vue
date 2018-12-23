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
        <v-list-tile slot="activator">
          <v-list-tile-title>記録を見る</v-list-tile-title>
        </v-list-tile>

        <router-link tag="div" :to="eventsPath">
          <v-list-tile>
            <v-list-tile-action>
              <v-icon>fa-microphone</v-icon>
            </v-list-tile-action>
            <v-list-tile-title>カラオケ一覧</v-list-tile-title>
          </v-list-tile>
        </router-link>

        <router-link v-show="!!currentUser" tag="div" :to="eventsPath">
          <v-list-tile>
            <v-list-tile-action>
              <v-icon>fa-plus-square</v-icon>
            </v-list-tile-action>
            <v-list-tile-title>カラオケ新規登録</v-list-tile-title>
          </v-list-tile>
        </router-link>
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
            <v-list-tile>
              <a>
                <v-list-tile-title @click="logout">ログアウト</v-list-tile-title>
              </a>
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
    <div class="history-dialog-outer" v-if="isShowHistoryDialog">
      <history-dialog />
      <v-btn
        v-show="true"
        @click="hideHistoryDialog"
        color="pink accent-1"
        class="close-button elevation-12"
        fixed bottom right fab
      >
        <v-icon>close</v-icon>
      </v-btn>
    </div>


    <!-- スナック TODO: もう少し汎用化したいね -->
    <v-snackbar v-model="isShowSuccessSnack" top color="success">
      {{ successSnackLabel }}
      <v-btn dark flat @click.native="isShowSuccessSnack = false">閉じる</v-btn>
    </v-snackbar>

    <v-snackbar v-model="isShowFailedSnack" top color="error">
      {{ failedSnackLabel }}
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
.history-dialog-outer {
  .close-button {
    z-index: 999;
    opacity: 0.4;
  }
}
</style>

<script>
  import { mapState, mapActions } from 'vuex'
  import { ROUTES } from '../lib/routes'
  const namespace = 'common'

  export default {
    data: function() {
      return {
        isShowNavigation: false,
        isShowLoginForm: false,
        isShowSuccessSnack: false,
        isShowFailedSnack: false,
        successSnackLabel: '',
        failedSnackLabel: ''
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
        'loginByToken',
        'hideHistoryDialog'
      ]),
      login (name, password) {
        this.$store.dispatch('common/login', { name, password })
          .then(() => {
            this.isShowSuccessSnack = true
            this.isShowFailedSnack = false
            this.isShowLoginForm = false
            this.successSnackLabel = 'ログインしました'
          })
          .catch((err) => {
            this.isShowFailedSnack = true
            this.isShowSuccessSnack = false
            this.failedSnackLabel = 'ログインに失敗しました'
          })
      },
      logout () {
        this.$store.dispatch('common/logout')
        this.isShowSuccessSnack = true
        this.successSnackLabel = 'ログアウトしました'
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
