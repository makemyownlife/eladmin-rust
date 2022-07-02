import request from '@/utils/request'

export function get(dictName) {
  const params = {
    dict_name: dictName,
    page: 0,
    size: 9999
  }
  return request({
    url: 'api/v1/dictdetail/query',
    method: 'post',
    data: params
  })
}

export function getDictMap(dictName) {
  const params = {
    dictName,
    page: 0,
    size: 9999
  }
  return request({
    url: 'api/v1/dict_detail/map',
    method: 'get',
    params
  })
}

export function add(data) {
  return request({
    url: 'api/v1/dict_detail/save',
    method: 'post',
    data
  })
}

export function del(ids) {
  return request({
    url: 'api/v1/dict_detail/delete_ids',
    method: 'post',
    data: ids
  })
}

export function edit(data) {
  return request({
    url: 'api/v1/dict_detail/update',
    method: 'post',
    data
  })
}

export default { add, edit, del }
