import request from '@/utils/request'
import qs from 'qs'

export function initData(url, params) {
  return request({
    url: `${url}/${params.page + 1}/${params.size}`, // + '?' + qs.stringify(params, { indices: false }),
    method: 'post',
    data: params
  })
}

export function initCtxData(url, method, params) {
  if (method === 'get') {
    return request({
      url: `${url}/${params.page + 1}/${params.size}`, // + '?' + qs.stringify(params, { indices: false }),
      method: method,
      params
    })
  } else {
    return request({
      url: `${url}/${params.page + 1}/${params.size}`, // + '?' + qs.stringify(params, { indices: false }),
      method: method,
      data: params
    })
  }
}

export function download(url, params) {
  return request({
    url: url + '?' + qs.stringify(params, { indices: false }),
    method: 'get',
    responseType: 'blob'
  })
}
