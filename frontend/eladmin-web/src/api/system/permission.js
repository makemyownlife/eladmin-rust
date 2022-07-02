import request from '@/utils/request'

export function getAllJob() {
  const params = {
    page: 0,
    size: 9999,
    enabled: true
  }
  return request({
    url: 'api/v1/permission/search',
    method: 'post',
    data: params
  })
}

export function querySubPermissions(id) {
  const params = {
    page: 0,
    size: 9999,
    enabled: true,
    pid: id
  }
  return request({
    url: 'api/v1/permission/search',
    method: 'post',
    data: params
  })
}

export function add(data) {
  return request({
    url: 'api/v1/permission/save',
    method: 'post',
    data
  })
}

export function del(ids) {
  return request({
    url: 'api/v1/permission/delete_ids',
    method: 'post',
    data: [ids]
  })
}

export function edit(data) {
  return request({
    url: 'api/v1/permission/update',
    method: 'post',
    data
  })
}

export function getPermissionTree() {
  return request({
    url: 'api/v1/permission/search',
    method: 'post',
    data: {}
  })
}

export function getPermissionChildren(id) {
  return request({
    url: 'api/v1/permission/children?pid=' + id,
    method: 'get'
  })
}

export default { add, edit, del }
