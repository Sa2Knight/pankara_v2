<template>
  <div>
    <!-- ヘッダーツールバー -->
    <v-toolbar app>
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

    <!-- カラオケ作成/編集ダイアログ -->
    <div class="event-dialog-outer" v-if="isShowEventDialog">
      <EventDialog />
      <!-- TODO: この辺共通化したい-->
      <v-btn
        v-show="true"
        @click="hideEventDialog"
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
  import LoginForm from '@component/parts/Common/LoginForm'
  import HistoryDialog from '@component/parts/Common/HistoryDialog'
  import TheLoadingView from '@component/parts/Common/TheLoadingView'
  import VUserIcon from '@component/common/VUserIcon'
  const namespace = 'common'

  export default {
    components: {
      LoginForm,
      HistoryDialog,
      TheLoadingView,
      VUserIcon,
    },
    data: function() {
      return {
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
        isShowHistoryDialog: state => state.isShowHistoryDialog,
        isShowEventDialog: state => state.isShowEventDialog,
        isLoading: state => state.isLoading
      })
    },
    methods: {
      ...mapActions(namespace, [
        'loginByToken',
        'hideHistoryDialog',
        'hideEventDialog'
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
  }
</script>
