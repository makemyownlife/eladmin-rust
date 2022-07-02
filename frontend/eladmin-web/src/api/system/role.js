import request from '@/utils/request'

// 获取所有的Role
export function getAll() {
  return request({
    url: 'api/v1/role/search',
    method: 'post',
    data: {}
  })
}

export function add(data) {
  return request({
    url: 'api/v1/role/save',
    method: 'post',
    data
  })
}

export function get(id) {
  return request({
    url: 'api/v1/role/get/' + id,
    method: 'get'
  })
}

export function getLevel() {
  return request({
    url: 'api/v1/role/level',
    method: 'get'
  })
}

export function del(ids) {
  return request({
    url: 'api/v1/role_menus/remove_ids',
    method: 'post',
    data: ids
  })
}

export function edit(data) {
  return request({
    url: 'api/v1/role/update',
    method: 'post',
    data
  })
}

export function editMenu(data) {
  return request({
    url: 'api/v1/role_menus/save',
    method: 'post',
    data
  })
}

export default { add, edit, del, get, editMenu, getLevel }
