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

          <v-list-tile>
            <v-list-tile-title>カラオケ一覧</v-list-tile-title>
            <v-list-tile-action>
              <v-icon>fa-microphone</v-icon>
            </v-list-tile-action>
          </v-list-tile>

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
      <v-toolbar-title>カラオケ一覧</v-toolbar-title>
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
    <v-dialog v-model="isShowLoginForm" max-width="500px">
      <login-form
        @close="isShowLoginForm = false"
      />
    </v-dialog>
  </div>
</template>

<script>
  export default {
    data: function() {
      return {
        isShowNavigation: false,
        isShowLoginForm: false
      }
    },
    components: {
      LoginForm: require('../component/parts/Common/LoginForm').default
    }
  }
</script>
