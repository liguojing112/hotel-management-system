<template>
    <div class="page-container">
        <div class="carousel">
            <el-carousel height="300px">
                <el-carousel-item>
                    <img src="@/assets/introduction.jpg" class="carousel-img" />
                </el-carousel-item>
                <el-carousel-item>
                    <img src="@/assets/jiudian.jpeg" class="carousel-img" />
                </el-carousel-item>
                <el-carousel-item>
                    <img src="@/assets/jiudian2.jpg" class="carousel-img" />
                </el-carousel-item>
            </el-carousel>
        </div>
        
        <div class="section">
            <div class="section-title">
                客房展示
            </div>
            <div class="section-list">

                <div v-for="item in categoryList" :key="item.id" class="section-item" @click="$router.push(`/front/room?categoryId=${item.id}`)">
                    <img :src="$baseFileUrl+item.photo" class="hotel-img">
                    <div class="hotel-title">{{ item.categoryName }}</div>
                    <div class="flex justify-between item-center w-full">
                        <div class="hotel-price">￥{{ item.price }}</div>
                    </div>
                </div>

                <!-- 多写两个标签解决flex最后一行对齐问题 -->
                <div class="section-item-empty"></div>
                <div class="section-item-empty"></div>
            </div>
        </div>
        <div class="section">
            <div class="section-title">
                民宿简介
            </div>
            <div class="hotel-introduction">
                <div class="introduction">
                    爪哇民宿位于白云区商业核心区域，毗邻白云国际会展中心及广州体育馆，举步可至繁华的万达广场及多家高级时尚购物中心。
                    如果你想探索充满活力的花城广州或附近城市，你会发现民宿可接驳多条高速公路、快速路便捷通过城市繁忙的交通，驱车约15分钟抵达天河中心商业区。
                    民宿拥有三百余间宽敞舒适的客房及套房，采用明亮淡雅的色调和丰富的木料，精心营造出希尔顿现代典雅的风格。高端的现代科技应用于房内的各项设施，
                    客房内可开式全景落地玻璃窗带来自然的光线，饱览白云新城美景。
                    3,220平方米会议及宴会场地，其中包括1个1,500平方米的壮观典雅的无柱式大宴会厅，内设有83平方米高清LED屏幕(P2分辨率)。
                    4间风格迥异的餐厅及酒吧让您饕餮羊城美食。希尔顿特色水疗中心，装潢华丽的私人护理套房，让客人立即进入宁静的冥想世界。
                    装备完善的健身房、室内恒温游泳池，以及蒸汽房、桑拿、按摩池和旋水池等让你释放淋漓激情。无论商务或休闲，爪哇民宿是你下榻广州的无忧之选。
                </div>
                <div class="hotel-img">
                    <img src="@/assets/introduction.jpg" />
                </div>
            </div>

        </div>
        <div class="section">
            <div class="section-title">
                最新公告
            </div>
            <el-table class="my-20" :data="noticeList" border fit highlight-current-row size="small">
                <el-table-column align="center" label="ID" prop="id"></el-table-column>
                <el-table-column align="center" label="标题" prop="title" show-overflow-tooltip></el-table-column>
                <el-table-column align="center" label="发布时间" prop="createTime"></el-table-column>
                <el-table-column fixed="right" label="操作" width="100">
                    <template slot-scope="scope">
                        <el-button @click="$router.push(`/front/noticeDetails/${scope.row.id}`)" type="text" size="small">查看</el-button>
                    </template>
                </el-table-column>
            </el-table>
        </div>
    </div>
</template>

<script>
import { getTop5NoticeAPI } from '@/api/notice'
import {findAllCategoryAPI} from '@/api/category'
export default {
    name: 'Hotely5dWebHome',

    data() {
        return {
            noticeList: [],
            categoryList: []
        };
    },

    async mounted() {
        const { data: noticeList } = await getTop5NoticeAPI()
        this.noticeList = noticeList
        const {data: categoryList} = await findAllCategoryAPI()
        this.categoryList = categoryList
    },

    methods: {

    },
};
</script>

<style lang="less" scoped>
.carousel {
    margin-bottom: 20px;

    .carousel-img {
        width: 100%;
        height: 300px;
        background-size: cover;
    }
}

.page-container {
    width: 1200px;
    margin: 20px auto;


    .section {
        .section-title {
            background-color: #303643;
            color: azure;
            padding: 16px;
            border-radius: 6px;
            text-align: center;
        }

        .section-list {
            margin: 20px 0;
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;

            // //重要 解决最后一行两端对齐的问题
            &::after {
                content: '';
                // flex: 1;
                width: 290px;
            }

            .section-item-empty {
                width: 290px;
            }

            .section-item {
                // width: 290px;
                width: 290px;
                height: 300px;
                padding: 16px;
                box-sizing: border-box;
                border-radius: 6px;
                margin-bottom: 10px;
                // background-color: antiquewhite;
                border: 1px solid #DCDFE6;
                cursor: pointer;

                // margin-left: 10px;
                // 等差数列(n-1)*4+1：1 4 9 13 左边距0 每行的第一个元素
                &:nth-child(4n-3) {
                    // background-color: deepskyblue;
                    margin-left: 0 !important;
                }

                .hotel-img {
                    width: 100%;
                    height: 200px;
                }

                .hotel-title {
                    font-weight: bold;
                    width: 100%;
                    margin: 10px;
                    text-overflow: ellipsis;
                    overflow: hidden;
                    white-space: nowrap;
                }

                .hotel-price {
                    color: red;
                    width: 100%;
                    margin: 4px;
                    text-align: right;
                }


            }
        }
    }

    .hotel-introduction {
        display: flex;
        justify-content: space-around;
        align-items: center;

        .hotel-img {
            flex: 1;
            margin: 20px 10px;

            img {
                width: 100%;
                height: 350px;
                border-radius: 6px;
            }
        }

        .introduction {
            height: 350px;
            flex: 1;
            line-height: 1.5;
            color: #303643;
            font-size: 18px;
        }
    }
}

.el-carousel__item h3 {
    color: #475669;
    font-size: 14px;
    opacity: 0.75;
    line-height: 150px;
    margin: 0;
}

.el-carousel__item:nth-child(2n) {
    background-color: #99a9bf;
}

.el-carousel__item:nth-child(2n+1) {
    background-color: #d3dce6;
}
</style>