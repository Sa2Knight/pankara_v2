<template>
  <div>
    <!-- ヘッダーツールバー -->
    <v-toolbar app>
      <v-toolbar-title>{{ pageTitle }}</v-toolbar-title>
      <v-spacer></v-spacer>
      <v-toolbar-items>
        <v-menu bottom left>
          <v-btn v-if="currentUser" class="login-user-icon-outer" slot="activator" >
            <img :src="currentUser.image_url" >
          </v-btn>
          <v-btn v-else slot="activator" black icon>
            <v-icon>more_vert</v-icon>
          </v-btn>
          <v-list>
            <!-- 全体向けのメニュー -->
            <v-list-tile>
              <router-link :to="{ name: 'Events' }">
                <v-list-tile-title>カラオケ一覧</v-list-tile-title>
              </router-link>
            </v-list-tile>

            <!-- ログイン中ユーザのみのメニュー -->
            <template v-if="currentUser">
              <v-list-tile>
                <router-link :to="{ name: 'UserMySongs', params: { id: currentUser.id } }">
                  <v-list-tile-title>持ち歌一覧</v-list-tile-title>
                </router-link>
              </v-list-tile>
              <v-list-tile>
                <router-link :to="{ name: 'Histories' }">
                  <v-list-tile-title>歌唱履歴</v-list-tile-title>
                </router-link>
              </v-list-tile>
              <v-list-tile @click="logout">
                <a><v-list-tile-title>ログアウト</v-list-tile-title></a>
              </v-list-tile>
            </template>

            <!-- 未ログイン中ユーザのみのメニュー -->
            <template v-else>
              <v-list-tile @click="isShowLoginForm = true">
                <a><v-list-tile-title>ログイン</v-list-tile-title></a>
              </v-list-tile>
            </template>
          </v-list>
        </v-menu>
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
  import EventDialog from '@component/parts/Common/EventDialog'
  import TheLoadingView from '@component/parts/Common/TheLoadingView'
  import VUserIcon from '@component/common/VUserIcon'
  const namespace = 'common'

  export default {
    components: {
      LoginForm,
      HistoryDialog,
      EventDialog,
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
