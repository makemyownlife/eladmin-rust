import request from '@/utils/request'

export function getMenusTree(pid) {
  return request({
    url: 'api/v1/menu/search',
    method: 'post',
    data: { pid: pid === 0 ? null : pid }
  })
}

export function getMenus(params) {
  return request({
    url: 'api/v1/menu/search',
    method: 'post',
    data: params
  })
}

export function getMenuSuperior(ids) {
  const data = Array.isArray(ids) || ids.length === 0 ? ids : Array.of(ids)
  return request({
    url: 'api/v1/menu/superior',
    method: 'post',
    data
  })
}

export function getChild(id) {
  return request({
    url: 'api/v1/menu/children?pid=' + id,
    method: 'get'
  })
}

export function buildMenus() {
  return request({
    url: 'api/v1/menus/build',
    method: 'get'
  })
}

export function add(data) {
  return request({
    url: 'api/v1/menu/save',
    method: 'post',
    data
  })
}

export function del(ids) {
  return request({
    url: 'api/v1/menu/delete_ids',
    method: 'post',
    data: ids
  })
}

export function edit(data) {
  return request({
    url: 'api/v1/menu/update',
    method: 'post',
    data
  })
}

export default { add, edit, del, getMenusTree, getMenuSuperior, getMenus, getChild }
