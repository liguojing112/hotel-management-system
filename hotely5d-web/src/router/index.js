import Vue from 'vue'
import VueRouter from 'vue-router'
import AdminLayout from '@/views/AdminLayout.vue'
import OperatorLayout from '@/views/OperatorLayout.vue'
import FrontLayout from '@/views/front/FrontLayout.vue'
import {getToken} from '@/utils/auth'
Vue.use(VueRouter)

const routes = [
	{
		path: '/',
		redirect: "/admin"
	},
  {
    path: '/login',
    name: 'Login',
    component: () => import(/* webpackChunkName: "welcome" */ '@/views/Login.vue')
  },
  {
    path: '/register',
    name: 'Register',
    component: () => import(/* webpackChunkName: "welcome" */ '@/views/front/Register.vue')
  },
  {
    path: '/admin',
    name: 'Admin',
    component: AdminLayout,
    children: [
      {
        path: '',
        name: 'Welcome',
        component: () => import(/* webpackChunkName: "welcome" */ '@/views/Welcome.vue')
      },
      {
        path: 'admin',
        name: 'admin',
        component: () => import(/* webpackChunkName: "Admin" */ '@/views/Admin.vue')
      },
      {
        path: 'appointment',
        name: 'appointment',
        component: () => import(/* webpackChunkName: "Appointment" */ '@/views/Appointment.vue')
      },
      {
        path: 'category',
        name: 'category',
        component: () => import(/* webpackChunkName: "Category" */ '@/views/Category.vue')
      },
      {
        path: 'member',
        name: 'member',
        component: () => import(/* webpackChunkName: "Member" */ '@/views/Member.vue')
      },
      {
        path: 'message',
        name: 'message',
        component: () => import(/* webpackChunkName: "Message" */ '@/views/Message.vue')
      },
      {
        path: 'notice',
        name: 'notice',
        component: () => import(/* webpackChunkName: "Notice" */ '@/views/Notice.vue')
      },
      {
        path: 'orders',
        name: 'orders',
        component: () => import(/* webpackChunkName: "Orders" */ '@/views/Orders.vue')
      },
      {
        path: 'room',
        name: 'room',
        component: () => import(/* webpackChunkName: "Room" */ '@/views/Room.vue')
      },
      {
        path: 'adminInfo',
        name: 'AdminInfo',
        component: () => import(/* webpackChunkName: "Room" */ '@/views/AdminInfo.vue')
      },
      {
        path: 'addOrders',
        name: 'OrdersAdd',
        component: () => import(/* webpackChunkName: "Room" */ '@/views/OrdersAdd.vue')
      },
      {
        path: 'operator-manage',
        name: 'operator-manage',
        component: () => import(/* webpackChunkName: "Admin" */ '@/views/OperatorManage.vue')
      },
      {
        path: 'scenic-spot',
        name: 'scenic-spot',
        component: () => import(/* webpackChunkName: "Admin" */ '@/views/ScenicSpot.vue')
      },
    ]
  },
  {
    path: '/operator',
    name: 'Operator',
    component: OperatorLayout,
    children: [
      {
        path: '',
        name: 'OperatorWelcome',
        component: () => import(/* webpackChunkName: "operator" */ '@/views/operator/Welcome.vue')
      },
      {
        path: 'category',
        name: 'OperatorCategory',
        component: () => import(/* webpackChunkName: "operator" */ '@/views/Category.vue')
      },
      {
        path: 'room',
        name: 'OperatorRoom',
        component: () => import(/* webpackChunkName: "operator" */ '@/views/Room.vue')
      },
      {
        path: 'appointment',
        name: 'OperatorAppointment',
        component: () => import(/* webpackChunkName: "operator" */ '@/views/Appointment.vue')
      },
      {
        path: 'orders',
        name: 'OperatorOrders',
        component: () => import(/* webpackChunkName: "operator" */ '@/views/Orders.vue')
      },
      {
        path: 'message',
        name: 'OperatorMessage',
        component: () => import(/* webpackChunkName: "operator" */ '@/views/Message.vue')
      },
      {
        path: 'notice',
        name: 'OperatorNotice',
        component: () => import(/* webpackChunkName: "operator" */ '@/views/Notice.vue')
      },
      {
        path: 'operatorInfo',
        name: 'OperatorInfo',
        component: () => import(/* webpackChunkName: "operator" */ '@/views/operator/OperatorInfo.vue')
      },
      {
        path: 'addOrders',
        name: 'OperatorOrdersAdd',
        component: () => import(/* webpackChunkName: "operator" */ '@/views/OrdersAdd.vue')
      },
    ]
  },
  {
    path: '/front',
    name: 'Front',
    component: FrontLayout,
    children: [
      {
        path: '',
        name: 'Home',
        component: () => import(/* webpackChunkName: "welcome" */ '@/views/front/Home.vue')
      },
      {
        path: 'room',
        name: 'Room',
        component: () => import(/* webpackChunkName: "welcome" */ '@/views/front/Room.vue')
      },
      {
        path: 'roomDetails/:id',
        name: 'RoomDetails',
        component: () => import(/* webpackChunkName: "welcome" */ '@/views/front/RoomDetails.vue')
      },
      {
        path: 'notice',
        name: 'Notice',
        component: () => import(/* webpackChunkName: "welcome" */ '@/views/front/Notice.vue')
      },
      {
        path: 'noticeDetails/:id',
        name: 'NoticeDetails',
        component: () => import(/* webpackChunkName: "welcome" */ '@/views/front/NoticeDetails.vue')
      },
      {
        path: 'message',
        name: 'Message',
        component: () => import(/* webpackChunkName: "welcome" */ '@/views/front/Message.vue')
      },
      {
        path: 'userInfo',
        name: 'UserInfo',
        component: () => import(/* webpackChunkName: "welcome" */ '@/views/front/UserInfo.vue')
      },
      {
        path: 'appointment',
        name: 'MyAppointment',
        component: () => import(/* webpackChunkName: "welcome" */ '@/views/front/MyAppointment.vue')
      },
      {
        path: 'orders',
        name: 'MyOrders',
        component: () => import(/* webpackChunkName: "welcome" */ '@/views/front/MyOrder.vue')
      },
    ]
  }

]

const router = new VueRouter({
  routes
})

const whiteList = [
  "/login",
  "/register",
  "/front",
  "/front/room",
  "/front/notice",
  "/front/message"
]
const whiteListWithDetails = [
  "/front/roomDetails/",
  "/front/noticeDetails/",
]

router.beforeEach((to, from, next) => {
	const isLogin = getToken()
	if (isLogin) {
		next()
	} else {
		if (whiteList.includes(to.fullPath) || whiteList.includes(to.path) || whiteListWithDetails.some(s => to.fullPath.startsWith(s))) {
			next();
		} else {
			next({
				path: '/login'
			})
		};
	};
})

export default router
