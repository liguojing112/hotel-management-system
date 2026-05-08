import request from '@/utils/request'

export const findOperatorPageAPI = (pageNum, pageSize, params) => {
    return request({
        url: `/operator/search/${pageNum}/${pageSize}`,
        method: 'get',
        params
    })
}

export const addOperatorAPI = data => {
    return request({
        url: '/operator/',
        method: 'post',
        data
    })
}

export const modifyOperatorAPI = data => {
    return request({
        url: '/operator/',
        method: 'put',
        data
    })
}

export const removeOperatorAPI = id => {
    return request({
        url: `/operator/${id}`,
        method: 'delete'
    })
}

export const findOperatorByIdAPI = id => {
    return request({
        url: `/operator/${id}`,
        method: 'get'
    })
}

export const resetOperatorPasswordAPI = id => {
    return request({
        url: `/operator/${id}/reset-password`,
        method: 'put'
    })
}
