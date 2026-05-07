<template>
  <div>
    <el-menu :default-active="activeIndex" router class="el-menu-demo" mode="horizontal" background-color="#1a237e"
      text-color="#fff" active-text-color="#ffd54f">
      <el-menu-item style="border: none;" index="/front"><img src="@/assets/logo.png"
          height="30px" />{{ $sysTitle }}</el-menu-item>
      <el-menu-item index="/front">首页</el-menu-item>
      <el-menu-item v-if="!token" index='/login'>登录</el-menu-item>
      <el-menu-item v-if="!token" index='/register'>注册</el-menu-item>
      <el-menu-item index="/front/notice">系统公告</el-menu-item>
      <el-menu-item index="/front/message">用户留言</el-menu-item>
      <el-menu-item index="/front/room">预约入住</el-menu-item>
      <el-submenu v-if="token" index="#">
        <template slot="title">
          <el-avatar v-if="head" :src="$baseFileUrl+head"></el-avatar>
          <img v-else="head" src="@/assets/head.jpg" style="border-radius: 50%" width="30px" height="30px" />
          <span > {{ user?.name }}</span>
        </template>
        <el-menu-item index="/front/userInfo">个人信息</el-menu-item>
        <el-menu-item index="/front/appointment">我的预约</el-menu-item>
        <el-menu-item index="/front/orders">我的入住</el-menu-item>
        <el-menu-item index="#" @click.native="logout">退出登录</el-menu-item>
      </el-submenu>
    </el-menu>
    <div class="content">
      <router-view />
    </div>
    <div class="footer">
      Copyright &copy; {{ year }} {{ $sysTitle }}
    </div>
  </div>
</template>
    
<script>
import { mapState, mapMutations } from 'vuex'
import { removeToken } from '@/utils/auth'
export default {
  name: "Index",

  data() {
    return {
      activeIndex: "1",
      head: '',
      year: ''
    };
  },

  async mounted() {
    this.year = new Date().getFullYear();
    this.head = this.user?.head
  },

  computed: {
    ...mapState(['user', 'role', 'token'])
  },

  methods: {
    ...mapMutations(['setUser', 'setRole', 'setToken']),
    logout() {
      this.$confirm('确定退出吗?', '温馨提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        removeToken()
        this.setUser({})
        this.setToken('')
        this.$router.replace('/front')

      }).catch(() => { });
    }
  },
}
</script>
    
<style lang="less" scoped>
.el-menu-demo {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  z-index: 999;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
}

/deep/ .el-menu.el-menu--horizontal {
  border-bottom: none !important;
}

.content {
  min-height: calc(100vh - 60px - 60px);
  padding-top: 60px;
  background: #f8f9fa;
}

.footer {
  height: 60px;
  line-height: 60px;
  text-align: center;
  color: #fff;
  background: linear-gradient(135deg, #1a237e, #283593);
  font-size: 14px;
  letter-spacing: 1px;
}
</style>
