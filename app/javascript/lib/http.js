/**
 * APIサーバとの通信インタフェースモジュール
 * 各種API呼び出しメソッドはThenableなオブジェクトを戻す
 */
import axiosBase from 'axios'
const http = {}

/**
 * axiosの共通設定
 */
const axios = axiosBase.create({
  baseURL: '/api',
  headers: {
    'ContentType': 'application/json',
    'X-Requested-With': 'XMLHttpRequest'
  },
  responseType: 'json'
})

/**
 * リクエストオブジェクトを生成
 */
const request = function(method, url, params = {}) {
  const baseParams = {method, url}
  if (method === 'GET') {
    baseParams.params = params
  } else {
    baseParams.data = params
  }
  return axios(baseParams)
}

/**
 * ログインリクエスト
 */
http.login = function(name, password) {
  const params = {
    auth: {
      name: name,
      password: password
    }
  }
  return request('POST', '/user_token', params)
}

/**
 * イベント一覧を取得する
 */
http.getEvents = function(params = {}) {
  return request('GET', '/events', params)
}

export default http
