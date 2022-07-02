import request from '@/utils/request'

export function login(username, password, verify_code, verify_code_key) {
  return request({
    url: 'api/v1/auth/login',
    method: 'post',
    data: {
      username,
      password,
      verify_code,
      verify_code_key
    }
  })
}

export function getInfo() {
  return request({
    url: 'api/v1/auth/info',
    method: 'get'
  })
}

export function getCodeImg() {
  return request({
    url: 'api/v1/auth/code',
    method: 'get'
  })
}

export function logout() {
  return request({
    url: 'api/v1/auth/logout',
    method: 'post'
  })
}
