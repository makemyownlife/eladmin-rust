import request from '@/utils/request'
import { encrypt } from '@/utils/rsaEncrypt'

export function add(data) {
  return request({
    url: 'api/v1/user/save',
    method: 'post',
    data
  })
}

export function del(ids) {
  return request({
    url: 'api/v1/user/remove',
    method: 'delete',
    data: ids
  })
}

export function edit(data) {
  return request({
    url: 'api/v1/user/update',
    method: 'post',
    data
  })
}

export function get(userId) {
  return request({
    url: 'api/v1/user/get/' + userId,
    method: 'get'
  })
}

export function editUser(data) {
  return request({
    url: 'api/v1/user/center/update/info',
    method: 'post',
    data
  })
}

export function updatePass(user) {
  const data = {
    old_pwd: encrypt(user.oldPass),
    new_pwd: encrypt(user.newPass)
  }
  return request({
    url: 'api/v1/user/center/update/pwd',
    method: 'post',
    data
  })
}

export function updateEmail(form) {
  const data = {
    password: encrypt(form.pass),
    email: form.email,
    code: form.code
  }
  return request({
    url: 'api/v1/user/center/update/email?' + form.code,
    method: 'post',
    data
  })
}

export default { add, edit, del, get }

