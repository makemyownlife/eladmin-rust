import request from '@/utils/request'

export function getTemplates() {
  return request({
    url: 'api/v1/template/all',
    method: 'get'
  })
}

export function add(data) {
  return request({
    url: 'api/v1/template/save',
    method: 'post',
    data
  })
}

export function del(ids) {
  return request({
    url: 'api/v1/template/delete_ids',
    method: 'post',
    data: ids
  })
}

export function edit(data) {
  return request({
    url: 'api/v1/template/update',
    method: 'post',
    data
  })
}

export function get(id) {
  return request({
    url: 'api/v1/template/get/' + id,
    method: 'get'
  })
}

export default { add, edit, del, get }
