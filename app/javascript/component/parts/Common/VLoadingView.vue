<template>
  <div class="v-loading-view">
    <img src="images/loading.png" class="rotate-image">
  </div>
</template>

<style lang="scss">
/* http://on-ze.com/archives/510 */

.v-loading-view {
 width: 100%;
 height: 100%;
 z-index: 9999;
 position: fixed;
 top: 0;
 left: 0;
 background-color: #000000;
 filter: alpha(opacity=45);
 -moz-opacity: 0.5;
 -khtml-opacity: 0.5;
 opacity: 0.35;
 background-position: center center;
 background-repeat: no-repeat;
 background-attachment: fixed;

  .rotate-image {
    position: absolute;
    width: 4em;
    height: 4em;
    left: 50%;
    top: 50%;
    margin-left: -2em;
    margin-top: -2em;
    -webkit-animation: spin 1.5s linear infinite;
    -moz-animation: spin 1.5s linear infinite;
    -ms-animation: spin 1.5s linear infinite;
    -o-animation: spin 1.5s linear infinite;
     animation: spin 1.5s linear infinite;
  }

  @-webkit-keyframes spin {
    0% {-webkit-transform: rotate(0deg);}
    100% {-webkit-transform: rotate(360deg);}
  }
  @-moz-keyframes spin {
    0% {-moz-transform: rotate(0deg);}
    100% {-moz-transform: rotate(360deg);}
  }
  @-ms-keyframes spin {
    0% {-ms-transform: rotate(0deg);}
    100% {-ms-transform: rotate(360deg);}
  }
  @-o-keyframes spin {
    0% {-o-transform: rotate(0deg);}
    100% {-o-transform: rotate(360deg);}
  }
  @keyframes spin {
    0% {transform: rotate(0deg);}
    100% {transform: rotate(360deg);}
  }
}

</style>

<script>
  export default {
  }
</script>
