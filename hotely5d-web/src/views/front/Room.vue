<template>
    <div class="page-container">
        <div class="section">
            <div class="section-title">
                预约入住
            </div>
            <el-form :inline="true" :model="formInline" class="filter-form">
                <el-form-item label="入住日期">
                    <el-date-picker :clearable="false" :picker-options="pickerOptions" v-model="formInline.startDate"
                        type="date" placeholder="入住日期" value-format="yyyy-MM-dd" format="yyyy-MM-dd">
                    </el-date-picker>
                </el-form-item>
                <el-form-item label="房型">
                    <el-select v-model="formInline.categoryId" placeholder="房型" clearable>
                        <el-option v-for="item in categoryList" :label="item.categoryName" :value="item.id"
                            :key="item.id"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="状态">
                    <el-select v-model="formInline.canUse" placeholder="状态" clearable>
                        <el-option label="可预订" :value="true"></el-option>
                        <el-option label="已满房" :value="false"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item>
                    <el-button type="primary" @click="onSubmit">查询</el-button>
                </el-form-item>
            </el-form>

            <div class="hotel-list">
                <div
                    v-for="item in roomList"
                    :key="item.id"
                    class="hotel-card"
                    @click="$router.push(`/front/roomDetails/${item.id}`)"
                >
                    <div class="card-image-wrapper">
                        <img :src="$baseFileUrl + item.category.photo" class="card-image" />
                        <div class="status-badge" :class="item.canUse ? 'available' : 'full'">
                            {{ item.canUse ? '可预订' : '已满房' }}
                        </div>
                    </div>
                    <div class="card-info">
                        <h3 class="hotel-name">{{ item.category.categoryName }}-{{ item.roomNum }}</h3>
                        <div class="rating-row">
                            <span class="rating-score">{{ item.category.score || '4.8' }}</span>
                            <span class="rating-level">{{ item.category.level || '超棒' }}</span>
                            <span class="rating-count">{{ item.category.commentCount || '1200' }}条点评</span>
                        </div>
                        <p class="comment-text">"{{ item.category.comment || '环境舒适，服务周到' }}"</p>
                        <div class="card-footer">
                            <div class="hotel-price">￥{{ item.category.price }}</div>
                            <el-button type="primary" size="small" class="book-btn">
                                {{ item.canUse ? '立即预订' : '查看详情' }}
                            </el-button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import { findAllCategoryAPI } from '@/api/category'
import { findRoomListAPI } from '@/api/room'
import dayjs from 'dayjs'
export default {
    name: 'FrontCategory',

    data() {
        return {
            pickerOptions: {
                disabledDate: this.disabledDate
            },
            formInline: {
                startDate: dayjs().format('YYYY-MM-DD'),
                categoryId: null,
                canUse: null
            },
            categoryList: [],
            roomList: []
        };
    },

    async mounted() {
        if (this.$route.query?.categoryId) {
            this.formInline.categoryId = parseInt(this.$route.query?.categoryId)
        }
        this.getCategoryList()
        this.getList()
    },

    methods: {
        disabledDate(time) {
            //禁用今天之前的日期
            return dayjs(time).isBefore(dayjs(), 'day')
        },
        async getCategoryList() {
            const { data } = await findAllCategoryAPI()
            this.categoryList = data
        },
        async getList() {
            const { data } = await findRoomListAPI(this.formInline)
            this.roomList = data;
        },
        onSubmit() {
            this.getList()
        }
    },
};
</script>

<style lang="less" scoped>
.page-container {
    width: 1200px;
    margin: 20px auto;

    .section {
        .section-title {
            background-color: #303643;
            color: #fff;
            padding: 16px;
            border-radius: 6px;
            text-align: center;
            margin-bottom: 20px;
        }

        .filter-form {
            margin-bottom: 20px;
            padding: 16px;
            background: #fff;
            border-radius: 8px;
            border: 1px solid #f0f0f0;
        }

        .hotel-list {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;

            .hotel-card {
                flex: 0 0 calc((100% - 60px) / 4);
                max-width: calc((100% - 60px) / 4);
                background: #fff;
                border-radius: 8px;
                overflow: hidden;
                border: 1px solid #f0f0f0;
                cursor: pointer;
                transition: box-shadow 0.3s;
                margin-bottom: 4px;

                &:hover {
                    box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
                }

                .card-image-wrapper {
                    position: relative;
                    width: 100%;
                    height: 200px;
                    overflow: hidden;

                    .card-image {
                        width: 100%;
                        height: 100%;
                        object-fit: cover;
                        transition: transform 0.3s;
                    }

                    &:hover .card-image {
                        transform: scale(1.05);
                    }

                    .status-badge {
                        position: absolute;
                        top: 12px;
                        right: 12px;
                        padding: 4px 10px;
                        border-radius: 4px;
                        font-size: 12px;
                        font-weight: bold;
                        color: #fff;

                        &.available {
                            background: #67c23a;
                        }

                        &.full {
                            background: #f56c6c;
                        }
                    }
                }

                .card-info {
                    padding: 14px;

                    .hotel-name {
                        font-size: 15px;
                        font-weight: bold;
                        color: #333;
                        margin: 0 0 8px;
                        overflow: hidden;
                        text-overflow: ellipsis;
                        white-space: nowrap;
                    }

                    .rating-row {
                        display: flex;
                        align-items: center;
                        gap: 6px;
                        margin-bottom: 8px;

                        .rating-score {
                            font-size: 18px;
                            font-weight: bold;
                            color: #1a237e;
                        }

                        .rating-level {
                            font-size: 13px;
                            color: #1a237e;
                        }

                        .rating-count {
                            font-size: 13px;
                            color: #999;
                        }
                    }

                    .comment-text {
                        font-size: 13px;
                        color: #666;
                        margin: 0 0 12px;
                        overflow: hidden;
                        text-overflow: ellipsis;
                        white-space: nowrap;
                    }

                    .card-footer {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;

                        .hotel-price {
                            font-size: 18px;
                            font-weight: bold;
                            color: #f56c6c;
                        }

                        .book-btn {
                            background: #1a237e;
                            border-color: #1a237e;
                            border-radius: 4px;
                            font-size: 13px;

                            &:hover {
                                background: #283593;
                                border-color: #283593;
                            }
                        }
                    }
                }
            }
        }
    }
}
</style>
