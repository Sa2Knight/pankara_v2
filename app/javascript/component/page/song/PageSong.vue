<template>
  <div class="song">
    <div v-if="song">
      {{ song.name }}
    </div>
  </div>
</template>

<script>
  import { mapState } from 'vuex'
  export default {
    computed: {
      ...mapState({
        song: store => store.song.song
      })
    },
    methods: {
      // APIから楽曲詳細をフェッチ
      fetch: function() {
        this.$store.dispatch('fetchSong', this.$route.params.id)
      }
    },
    mounted: function() {
      this.fetch()
    }
  }
</script>
