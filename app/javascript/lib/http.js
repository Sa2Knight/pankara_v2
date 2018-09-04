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

/**
 * イベント詳細を取得する
 */
http.getEvent = function(id, params = {}) {
  return request('GET', `/events/${id}`, params)
}

/**
 * 楽曲詳細を取得する
 */
http.getSong = function(id, params = {}) {
  return request('GET', `/songs/${id}`, params)
}

/**
 * 楽曲の歌唱履歴を取得する
 */
http.getSongHistories = function(id, params = {}) {
  return request('GET', `/songs/${id}/histories`, params)
}

/**
 * 歌唱履歴の詳細を取得する
 */
http.getHistory = function(id, params = {}) {
  return request('GET', `/histories/${id}`, params)
}
export default http
