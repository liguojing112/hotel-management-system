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

        <!-- 热门城市 -->
        <div class="hot-cities-section">
            <div class="section-header">
                <div class="title-wrapper">
                    <h2 class="main-title">热门景区</h2>
                    <p class="sub-title">不同景区，<br>总有你喜欢的民宿。</p>
                </div>
                <div class="nav-wrapper">
                    <div class="city-tabs">
                        <span
                            v-for="city in visibleCities"
                            :key="city"
                            :class="['city-tab', { active: currentCity === city }]"
                            @click="switchCity(city)"
                        >
                            {{ city }}
                        </span>
                        <el-dropdown v-if="moreCities.length" @command="switchCity">
                            <span :class="['city-tab', 'more-tab', { active: moreCities.includes(currentCity) }]">
                                更多 <i class="el-icon-arrow-down el-icon--right"></i>
                            </span>
                            <el-dropdown-menu slot="dropdown">
                                <el-dropdown-item
                                    v-for="city in moreCities"
                                    :key="city"
                                    :command="city"
                                >
                                    {{ city }}
                                </el-dropdown-item>
                            </el-dropdown-menu>
                        </el-dropdown>
                    </div>
                    <div class="arrow-btns">
                        <div class="arrow-btn" @click="prevPage">
                            <i class="el-icon-arrow-left"></i>
                        </div>
                        <div class="arrow-btn" @click="nextPage">
                            <i class="el-icon-arrow-right"></i>
                        </div>
                    </div>
                </div>
            </div>

            <div class="hotel-carousel-wrapper">
                <div class="hotel-list" :style="listStyle">
                    <div
                        v-for="item in displayHotels"
                        :key="item.id"
                        class="hotel-card"
                        @click="$router.push(`/front/room?categoryId=${item.categoryId}`)"
                    >
                        <div class="card-image-wrapper">
                            <map-image
                                :src="item.photo"
                                :lat="item.lat"
                                :lng="item.lng"
                                :name="item.name"
                                fit="cover"
                                img-style="width:100%;height:100%;object-fit:cover"
                                class-name="card-image"
                            />
                            <div class="top-badge">
                                <div class="badge-inner">
                                    <div class="badge-dot"></div>
                                    <div class="badge-text">TOP</div>
                                    <div class="badge-level">高档</div>
                                </div>
                            </div>
                        </div>
                        <div class="card-info">
                            <h3 class="hotel-name">{{ item.name }}</h3>
                            <div class="rating-row">
                                <span class="rating-score">{{ item.score }}</span>
                                <span class="rating-level">{{ item.level }}</span>
                                <span class="rating-count">{{ item.commentCount }}条点评</span>
                            </div>
                            <p class="comment-text">"{{ item.comment }}"</p>
                            <div class="card-footer">
                                <el-button
                                    v-if="!token"
                                    type="primary"
                                    size="small"
                                    class="price-btn"
                                    @click.stop="$router.push('/login')"
                                >
                                    登录查看低价
                                </el-button>
                                <el-button
                                    v-else
                                    type="primary"
                                    size="small"
                                    class="price-btn"
                                    @click.stop="$router.push(`/front/room?categoryId=${item.categoryId}`)"
                                >
                                    查看详情
                                </el-button>
                            </div>
                        </div>
                    </div>
                </div>
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
import { mapState } from 'vuex'
import { getTop5NoticeAPI } from '@/api/notice'
import { findAllCategoryAPI } from '@/api/category'
import { findAllScenicSpotAPI } from '@/api/scenic-spot'

const ALL_CITIES = ['漓江', '象鼻山', '阳朔西街', '龙脊梯田', '两江四湖', '银子岩', '兴坪古镇', '遇龙河', '十里画廊', '世外桃源', '靖江王府']

const COMMENT_SAMPLES = [
    '非常适合出差游玩',
    '孩子高考首选酒店',
    '电视画质很清晰',
    '出差常备酒店',
    '服务态度非常好',
    '交通便利位置佳',
    '房间干净整洁',
    '早餐种类很丰富',
    '性价比超高推荐',
    '环境安静 slept well'
]

const LEVELS = ['超棒', '很好', '不错', '推荐']

export default {
    name: 'Hotely5dWebHome',

    data() {
        return {
            noticeList: [],
            categoryList: [],
            scenicSpots: [],
            currentCity: '漓江',
            cityPageIndex: 0,
            cityPageSize: 7,
            hotelPageIndex: 0,
            hotelsPerPage: 4
        };
    },

    computed: {
        ...mapState(['token']),
        cityCoordMap() {
            const map = {}
            this.scenicSpots.forEach(s => {
                map[s.cityName] = { lat: s.lat, lng: s.lng }
            })
            return map
        },
        visibleCities() {
            const start = this.cityPageIndex * this.cityPageSize
            return ALL_CITIES.slice(start, start + this.cityPageSize)
        },
        moreCities() {
            const start = this.cityPageIndex * this.cityPageSize + this.cityPageSize
            return ALL_CITIES.slice(start)
        },
        allHotels() {
            // 将 category 数据映射为带模拟数据的酒店列表，按城市分组展示
            if (!this.categoryList.length) return []
            const hotels = []
            let idx = 0
            // 为每个城市生成一些酒店（循环复用现有 category 数据，确保演示效果）
            ALL_CITIES.forEach((city, cityIdx) => {
                // 每个城市固定生成 8 个酒店，支持翻页和 4 列布局
                const count = 8
                for (let i = 0; i < count; i++) {
                    const cat = this.categoryList[idx % this.categoryList.length]
                    idx++
                    const score = (4.5 + Math.random() * 0.5).toFixed(1)
                    const level = LEVELS[Math.floor(Math.random() * LEVELS.length)]
                    const commentCount = Math.floor(1000 + Math.random() * 15000)
                    const comment = COMMENT_SAMPLES[Math.floor(Math.random() * COMMENT_SAMPLES.length)]
                    const coord = this.cityCoordMap[city] || {}
                    hotels.push({
                        id: `${city}-${cat.id}-${i}`,
                        categoryId: cat.id,
                        city: city,
                        name: cat.categoryName,
                        photo: this.$baseFileUrl + cat.photo,
                        lat: coord.lat,
                        lng: coord.lng,
                        score,
                        level,
                        commentCount,
                        comment
                    })
                }
            })
            return hotels
        },
        cityHotels() {
            return this.allHotels.filter(h => h.city === this.currentCity)
        },
        displayHotels() {
            const start = this.hotelPageIndex * this.hotelsPerPage
            return this.cityHotels.slice(start, start + this.hotelsPerPage)
        },
        listStyle() {
            // 这里只做简单横向排列，不用 translate 做滑动，避免复杂计算
            return {}
        }
    },

    async mounted() {
        const { data: noticeList } = await getTop5NoticeAPI()
        this.noticeList = noticeList
        const { data: categoryList } = await findAllCategoryAPI()
        this.categoryList = categoryList
        const { data: scenicSpots } = await findAllScenicSpotAPI()
        this.scenicSpots = scenicSpots
    },

    methods: {
        switchCity(city) {
            this.currentCity = city
            this.hotelPageIndex = 0
        },
        prevPage() {
            if (this.hotelPageIndex > 0) {
                this.hotelPageIndex--
            } else {
                // 翻到该城市最后一页
                const maxPage = Math.ceil(this.cityHotels.length / this.hotelsPerPage)
                this.hotelPageIndex = Math.max(0, maxPage - 1)
            }
        },
        nextPage() {
            const maxPage = Math.ceil(this.cityHotels.length / this.hotelsPerPage)
            if (this.hotelPageIndex < maxPage - 1) {
                this.hotelPageIndex++
            } else {
                this.hotelPageIndex = 0
            }
        }
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
}

/* 热门城市模块 */
.hot-cities-section {
    margin-bottom: 40px;

    .section-header {
        display: flex;
        align-items: flex-start;
        justify-content: space-between;
        margin-bottom: 20px;

        .title-wrapper {
            display: flex;
            align-items: flex-start;
            gap: 20px;

            .main-title {
                font-size: 36px;
                font-weight: bold;
                color: #333;
                margin: 0;
                line-height: 1.2;
            }

            .sub-title {
                font-size: 16px;
                color: #666;
                margin: 0;
                line-height: 1.5;
                padding-top: 4px;
            }
        }

        .nav-wrapper {
            display: flex;
            align-items: center;
            gap: 20px;
            padding-top: 8px;

            .city-tabs {
                display: flex;
                align-items: center;
                gap: 24px;

                .city-tab {
                    font-size: 15px;
                    color: #333;
                    cursor: pointer;
                    padding-bottom: 4px;
                    border-bottom: 2px solid transparent;
                    transition: all 0.3s;
                    user-select: none;

                    &:hover {
                        color: #1a237e;
                    }

                    &.active {
                        color: #1a237e;
                        border-bottom-color: #1a237e;
                        font-weight: bold;
                    }
                }

                .more-tab {
                    display: flex;
                    align-items: center;
                }
            }

            .arrow-btns {
                display: flex;
                gap: 10px;

                .arrow-btn {
                    width: 36px;
                    height: 36px;
                    border-radius: 50%;
                    border: 1px solid #e0e0e0;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    cursor: pointer;
                    transition: all 0.3s;
                    color: #666;

                    &:hover {
                        border-color: #1a237e;
                        color: #1a237e;
                    }
                }
            }
        }
    }

    .hotel-carousel-wrapper {
        overflow: hidden;

        .hotel-list {
            display: flex;
            gap: 20px;
            transition: transform 0.3s ease;
        }
    }

    .hotel-card {
        flex: 0 0 calc((100% - 60px) / 4);
        max-width: calc((100% - 60px) / 4);
        background: #fff;
        border-radius: 8px;
        overflow: hidden;
        border: 1px solid #f0f0f0;
        cursor: pointer;
        transition: box-shadow 0.3s;

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

            .top-badge {
                position: absolute;
                top: 0;
                right: 12px;
                width: 44px;
                height: 52px;
                background: linear-gradient(180deg, #c9a96e 0%, #a88b55 100%);
                border-radius: 0 0 4px 4px;
                display: flex;
                align-items: center;
                justify-content: center;
                box-shadow: 0 2px 6px rgba(0,0,0,0.15);

                .badge-inner {
                    text-align: center;
                    color: #fff;

                    .badge-dot {
                        width: 4px;
                        height: 4px;
                        background: #fff;
                        border-radius: 50%;
                        margin: 0 auto 2px;
                    }

                    .badge-text {
                        font-size: 10px;
                        line-height: 1;
                        letter-spacing: 1px;
                        margin-bottom: 2px;
                    }

                    .badge-level {
                        font-size: 13px;
                        font-weight: bold;
                        line-height: 1;
                    }
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
                justify-content: flex-end;

                .price-btn {
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

.section {
    .section-title {
        background-color: #303643;
        color: azure;
        padding: 16px;
        border-radius: 6px;
        text-align: center;
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
