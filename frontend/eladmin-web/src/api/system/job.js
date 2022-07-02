import request from '@/utils/request'

export function getAllJob() {
  const params = {
    page: 0,
    size: 9999,
    enabled: true
  }
  return request({
    url: 'api/v1/job/search',
    method: 'post',
    data: params
  })
}

export function add(data) {
  return request({
    url: 'api/v1/job/save',
    method: 'post',
    data
  })
}

export function del(ids) {
  return request({
    url: 'api/v1/job/delete_ids',
    method: 'post',
    data: ids
  })
}

export function edit(data) {
  return request({
    url: 'api/v1/job/update',
    method: 'post',
    data
  })
}

export default { add, edit, del }
