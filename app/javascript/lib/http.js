/**
 * APIサーバとの通信インタフェースモジュール
 * 各種API呼び出しメソッドはThenableなオブジェクトを戻す
 */
import axiosBase from 'axios'
const http = {}

/**
 * axiosの共通設定
 */
let axiosConfig = {
  baseURL: '/api',
  headers: {
    'ContentType': 'application/json',
    'X-Requested-With': 'XMLHttpRequest'
  },
  responseType: 'json'
}

/**
 * リクエストオブジェクトを生成
 */
const request = function(method, url, params = {}) {
  const jwtToken = localStorage.jwt
  axiosConfig.headers.Authorization = `Bearer ${jwtToken}`

  const axios = axiosBase.create(axiosConfig)
  const baseParams = {method, url}
  if (method === 'GET') {
    baseParams.params = params
  } else {
    const token = document.querySelector("input[name=authenticity_token]").value
    baseParams.data = params
    baseParams.data.authenticity_token = token
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
 * 自身の情報を取得
 */
http.getMySelf = function(params = {}) {
  return request('GET', '/users/myself', params)
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
 * イベントを作成する
 */
http.postEvents = function(params = {}) {
  return request('POST', `/events`, params)
}

/**
 * イベントを更新する
 */
http.patchEvent = function(id, params = {}) {
  return request('PATCH', `/events/${id}`, params)
}

/**
 * 楽曲一覧を取得する
 */
http.getSongs = function(params = {}) {
  return request('GET', `/songs`, params)
}

/**
 * 楽曲詳細を取得する
 */
http.getSong = function(id, params = {}) {
  return request('GET', `/songs/${id}`, params)
}

/**
 * 楽曲の曲名一覧を取得する
 */
http.getSongNames = function(params = {}) {
  return request('GET', `/songs/names`, params)
}

/**
 * 歌手詳細を取得する
 */
http.getArtist = function(id, params = {}) {
  return request('GET', `/artists/${id}`, params)
}

/**
 * 歌手名一覧を取得する
 */
http.getArtistNames = function(params = {}) {
  return request('GET', `/artists/names`, params)
}

/**
 * 歌唱履歴の一覧を取得する
 */
http.getHistories = function(params = {}) {
  return request('GET', '/histories', params)
}

/**
 * 歌唱履歴の詳細を取得する
 */
http.getHistory = function(id, params = {}) {
  return request('GET', `/histories/${id}`, params)
}

/**
 * 歌唱履歴を作成する
 */
http.postHistories = function(params = {}) {
  return request('POST', `/histories`, params)
}

export default http
