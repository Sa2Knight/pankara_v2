<template>
  <div app>
    <v-container fluid grid-list-md>

      <!-- 持ち歌一覧 -->
      <TheSangCountRemarks />
      <VPaginationWrapper v-if="mySongs"
        :pageOrigin="pageOrigin"
        :totalPages="totalPages"
        :changePage="fetchMySongsByPage"
      >
        <v-layout row wrap class="pb-5">
          <v-flex xs6 sm4 md3 lg2 v-for="song in mySongs">
            <v-song-card showArtistName :song="song" />
            <v-divider />
          </v-flex>
        </v-layout>
      </VPaginationWrapper>

      <!-- 検索ボタン -->
      <!-- TODO: 他の検索ボタンとまとめてコンポーネント化? -->
      <v-btn v-show="true" @click="showMySongsSearchDialog"
             color="gray" class="elevation-12" fixed bottom right fab dark small>
        <v-icon>search</v-icon>
      </v-btn>

    </v-container>

    <!-- 検索フォーム -->
    <v-dialog v-model="isShowMySongsSearchDialog" max-width="500px" persistent>
      <TheMySongsSearchForm />
    </v-dialog>

  </div>
</template>

<script>
  import { mapState, mapActions } from 'vuex'
  import PageCommonMixin from '@mixin/PageCommonMixin'
  import CONST from '@lib/constants'
  import VPaginationWrapper from '@component/common/VPaginationWrapper'
  import VSongCard from '@component/common/VSongCard'
  import TheSangCountRemarks from '@component/the/TheSangCountRemarks'
  import TheMySongsSearchForm from '@component/page/user/the/TheMySongsSearchForm'
  const namespace = 'user'

  export default {
    mixins: [PageCommonMixin],
    components: {
      TheSangCountRemarks,
      TheMySongsSearchForm,
      VPaginationWrapper,
      VSongCard,
    },
    computed: {
      ...mapState(namespace, [
        'mySongs',
        'isShowMySongsSearchDialog'
      ]),
      ...mapState(namespace, {
        pageOrigin: state => state.mySongsPager.page,
        totalPages: state => state.mySongsPager.totalPages,
      })
    },
    methods: {
      ...mapActions(namespace, [
        'fetchMySongs',
        'changePage',
        'showMySongsSearchDialog'
      ]),
      fetchMySongsByPage: function(page) {
        this.changePage(page)
        this.fetchMySongs(this.$route.params.id)
      }
    },
    mounted: function() {
      this.$store.dispatch('common/setPageTitle', '持ち歌一覧')
      this.fetchMySongsByPage()
    },
  }
</script>
