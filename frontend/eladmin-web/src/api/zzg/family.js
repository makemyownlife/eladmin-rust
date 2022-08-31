import request from '@/utils/request'

export function getDepts(params) {
  return request({
    url: `api/v1/dept/tree?pid=${params.pid}`,
    method: 'get'
  })
}

export function getDeptSuperior(ids) {
  const data = ids.length || ids.length === 0 ? ids : Array.of(ids)
  return request({
    url: 'api/v1/dept/superior',
    method: 'post',
    data
  })
}

export function add(data) {
  return request({
    url: 'api/v1/dept/save',
    method: 'post',
    data
  })
}

export function del(ids) {
  return request({
    url: 'api/v1/dept/delete_ids',
    method: 'post',
    data: ids
  })
}

export function edit(data) {
  return request({
    url: 'api/v1/dept/update',
    method: 'post',
    data
  })
}

export default { add, edit, del, getDepts, getDeptSuperior }
