import request from '@/utils/request'

export function get(dictName) {
  const params = {
    dict_name: dictName,
    page: 0,
    size: 9999
  }
  return request({
    url: 'api/v1/category_info/query',
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
    url: 'api/v1/category_info/map',
    method: 'get',
    params
  })
}

export function add(data) {
  return request({
    url: 'api/v1/category_info/save',
    method: 'post',
    data
  })
}

export function del(ids) {
  return request({
    url: 'api/v1/category_info/delete_ids',
    method: 'post',
    data: ids
  })
}

export function edit(data) {
  return request({
    url: 'api/v1/category_info/update',
    method: 'post',
    data
  })
}

export default { add, edit, del }
