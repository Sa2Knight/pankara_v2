const path = require('path');
const glob = require('glob');
const VueLoaderPlugin = require('vue-loader/lib/plugin')

module.exports = {
  // webpackが読み込むスタート地点
  entry: [
    __dirname + '/app/javascript/main.js',
  ].concat(
    // scssディレクトリ内の全てのファイルを対象にする
    glob.sync(__dirname + '/app/stylesheet/**/*.scss')
  ),
  // ビルド後の出力先
  output: {
    path: __dirname + '/app/assets/javascripts',
    filename: 'application.js',
  },
  module: {
    rules: [
      // .vueファイル
      {
        test: /\.vue$/,
        loader: 'vue-loader',
        options: {
          // postcss: [require('postcss-cssnext')()]
          // options: {
            //   extractCSS: true
            // }
          loaders: {
            js: 'babel-loader'
          }
        }
      },
      // .jsファイル
      {
        test: /\.js$/,
        exclude: /(node_modules|bower_components)/,
        use: [{
          loader: "babel-loader",
          options: { presets: ['es2015', 'stage-2'] }
        }]
      },
      // scssファイル
      { test: /\.scss$/, loader: 'style-loader!css-loader!sass-loader' },
      // cssファイル
      { test: /\.css$/, loader: 'style-loader!css-loader' },
      // other
      {
        test: /\.(jpg|png|otf|eot|svg|ttf|woff|woff2)(\?.+)?$/,
        loader: 'url-loader'
      },
    ],
  },
  resolve: {
    // vueを事前にコンパイル
    alias: {
      vue: 'vue/dist/vue.esm.js',
    },
    extensions: ['.vue', '.js'],
  },
  plugins: [
    new VueLoaderPlugin()
  ]
};
