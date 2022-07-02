import request from '@/utils/request'

export function getDicts() {
  return request({
    url: 'api/v1/dict/all',
    method: 'get'
  })
}

export function add(data) {
  return request({
    url: 'api/v1/dict/save',
    method: 'post',
    data
  })
}

export function del(ids) {
  return request({
    url: 'api/v1/dict/delete_ids',
    method: 'post',
    data: ids
  })
}

export function edit(data) {
  return request({
    url: 'api/v1/dict/update',
    method: 'post',
    data
  })
}

export default { add, edit, del }
