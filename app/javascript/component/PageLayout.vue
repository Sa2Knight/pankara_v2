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
      <v-toolbar-items>
        <v-btn flat @click="isShowLoginForm = true">ログイン</v-btn>
      </v-toolbar-items>
    </v-toolbar>

    <!-- コンテンツ -->
    <v-content>
      <v-container fluid>
        <router-view></router-view>
      </v-container>
    </v-content>

    <!-- ログインフォーム -->
    <!-- TODO: vuexで書き換え-->
    <v-dialog v-model="isShowLoginForm" max-width="500px">
      <login-form
        @success="isShowSuccessSnack = true"
        @failed="isShowFailedSnack = true"
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

<script>
  import { mapState } from 'vuex'
  import ROUTES from '../lib/routes'
  export default {
    data: function() {
      return {
        isShowNavigation: false,
        isShowLoginForm: false,
        isShowSuccessSnack: false,
        isShowFailedSnack: false,
      }
    },
    computed: {
      eventsPath: () => ROUTES.EVENTS_PATH(),
      ...mapState({
        pageTitle: state => state.common.pageTitle,
        isShowYoutubeDialog: state => state.common.isShowYoutubeDialog,
        isShowHistoryDialog: state => state.common.isShowHistoryDialog,
        isLoading: state => state.common.isLoading,
      })
    },
    components: {
      LoginForm: require('../component/parts/Common/LoginForm').default,
      YoutubeDialog: require('../component/parts/Common/YoutubeDialog').default,
      HistoryDialog: require('../component/parts/Common/HistoryDialog').default,
      TheLoadingView:  require('../component/parts/Common/TheLoadingView').default
    },
  }
</script>
