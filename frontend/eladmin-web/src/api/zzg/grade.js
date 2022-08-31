import request from '@/utils/request'

export function grade() {
  return request({
    url: 'api/v1/grade/list',
    method: 'get'
  })
}

export function get(subject_id) {
  return request({
    url: 'api/v1/subject/get/' + subject_id,
    method: 'get'
  })
}

export function add(data) {
  return request({
    url: 'api/v1/subject/save',
    method: 'post',
    data
  })
}

export function del(ids) {
  return request({
    url: 'api/v1/subject/delete_ids',
    method: 'post',
    data: ids
  })
}

export function edit(data) {
  return request({
    url: 'api/v1/subject/update',
    method: 'post',
    data
  })
}

export default { add, edit, del, get, grade }
