import request from '@/utils/request'

export const findScenicSpotPageAPI = (pageNum, pageSize, params) => {
    return request({
        url: `/scenic-spot/search/${pageNum}/${pageSize}`,
        method: 'get',
        params
    })
}

export const findAllScenicSpotAPI = () => {
    return request({
        url: '/scenic-spot/',
        method: 'get'
    })
}

export const addScenicSpotAPI = data => {
    return request({
        url: '/scenic-spot/',
        method: 'post',
        data
    })
}

export const modifyScenicSpotAPI = data => {
    return request({
        url: '/scenic-spot/',
        method: 'put',
        data
    })
}

export const removeScenicSpotAPI = id => {
    return request({
        url: `/scenic-spot/${id}`,
        method: 'delete'
    })
}

export const findScenicSpotByIdAPI = id => {
    return request({
        url: `/scenic-spot/${id}`,
        method: 'get'
    })
}
