<template>
  <div>
    <el-menu :default-active="activeIndex" router class="el-menu-demo" mode="horizontal" background-color="#1a237e"
      text-color="#fff" active-text-color="#ffd54f">
      <el-menu-item style="border: none;" index="/operator"><img src="@/assets/logo.png"
          height="30px" />{{ $sysTitle }}前台</el-menu-item>
      <el-menu-item index="/operator">首页</el-menu-item>
      <el-menu-item index="/operator/category">房型管理</el-menu-item>
      <el-menu-item index="/operator/room">房间管理</el-menu-item>
      <el-menu-item index="/operator/appointment">预约管理</el-menu-item>
      <el-menu-item index="/operator/orders">入住管理</el-menu-item>
      <el-menu-item index="/operator/message">留言管理</el-menu-item>
      <el-menu-item index="/operator/notice">公告管理</el-menu-item>
      <el-submenu index="#" style="margin-left: auto;">
        <template slot="title">
          <i class="el-icon-user-solid" style="color:#ffd54f;margin-right:4px;"></i>
          <span>{{ user.name || '操作员' }}</span>
        </template>
        <el-menu-item index="/operator/operatorInfo">个人信息</el-menu-item>
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
  name: "OperatorLayout",

  data() {
    return {
      activeIndex: "1",
      year: ''
    };
  },

  mounted() {
    this.year = new Date().getFullYear();
  },

  computed: {
    ...mapState(['user'])
  },

  methods: {
    ...mapMutations(['setUser', 'setToken']),
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
  background: #f5f7fa;
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
