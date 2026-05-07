<template>
    <div class="login-container">
        <div class="login-left">
            <div class="brand-area">
                <img src="@/assets/logo.png" class="brand-logo" />
                <h1 class="brand-title">{{ $sysTitle }}</h1>
                <p class="brand-desc">智慧民宿 · 高效管理 · 优质服务</p>
            </div>
        </div>
        <div class="login-right">
            <div class="login-box">
                <h2 class="login-title">欢迎登录</h2>
                <p class="login-subtitle">{{ $sysTitle }}管理系统</p>
                <el-form :model="loginForm" label-position="top">
                    <el-form-item label="账号">
                        <el-input v-model="loginForm.username" placeholder="请输入账户" prefix-icon="el-icon-user"></el-input>
                    </el-form-item>
                    <el-form-item label="密码">
                        <el-input v-model="loginForm.password" type="password" placeholder="请输入密码" prefix-icon="el-icon-lock" @keyup.enter.native="login"></el-input>
                    </el-form-item>
                    <el-form-item label="身份">
                        <el-radio-group v-model="loginForm.role" class="role-group">
                            <el-radio :label="1" class="role-item">
                                <i class="el-icon-s-custom"></i> 管理员
                            </el-radio>
                            <el-radio :label="3" class="role-item">
                                <i class="el-icon-s-cooperation"></i> 经营者
                            </el-radio>
                            <el-radio :label="2" class="role-item">
                                <i class="el-icon-user"></i> 用户
                            </el-radio>
                        </el-radio-group>
                    </el-form-item>
                    <el-form-item>
                        <el-button type="primary" class="login-btn" @click="login">登 录</el-button>
                    </el-form-item>
                    <div class="login-footer" v-if="loginForm.role == 2">
                        没有账号？<router-link to="/register" class="register-link">立即注册</router-link>
                    </div>
                </el-form>
            </div>
        </div>
    </div>
</template>

<script>
import { loginAPI, getUserInfoByTokenAPI } from '@/api/system'
import { mapMutations } from 'vuex'
import { setToken } from '@/utils/auth'
export default {
    name: 'Login',
    data() {
        return {
            loginForm: {
                role: 1,
                username: '',
                password: ''
            }
        }
    },
    methods: {
        ...mapMutations(['setUser', 'setRole', 'setToken']),
        async login() {
            if (!this.loginForm.username || !this.loginForm.password) {
                this.$message.warning('请输入账号和密码')
                return
            }
            const res = await loginAPI(this.loginForm)
            this.$message({
                type: res.flag ? 'success' : 'error',
                message: res.message
            })
            if (res.flag) {
                setToken(res.data)
                this.setToken(res.data)
                const result = await getUserInfoByTokenAPI()
                this.setUser(result.data)
                this.setRole(this.loginForm.role)
                if (this.loginForm.role == 1) {
                    this.$router.replace("/admin")
                } else if (this.loginForm.role == 3) {
                    this.$router.replace("/operator")
                } else {
                    this.$router.replace("/front")
                }
            }
        }
    }
}
</script>

<style lang="less" scoped>
.login-container {
    width: 100vw;
    height: 100vh;
    display: flex;
    overflow: hidden;
}

.login-left {
    flex: 1;
    background: linear-gradient(135deg, #1a237e 0%, #283593 50%, #3949ab 100%);
    display: flex;
    align-items: center;
    justify-content: center;
    position: relative;
    overflow: hidden;

    &::before {
        content: '';
        position: absolute;
        width: 600px;
        height: 600px;
        border-radius: 50%;
        background: rgba(255, 255, 255, 0.03);
        top: -200px;
        right: -200px;
    }

    &::after {
        content: '';
        position: absolute;
        width: 400px;
        height: 400px;
        border-radius: 50%;
        background: rgba(255, 255, 255, 0.05);
        bottom: -100px;
        left: -100px;
    }

    .brand-area {
        text-align: center;
        z-index: 1;

        .brand-logo {
            width: 80px;
            height: 80px;
            margin-bottom: 24px;
        }

        .brand-title {
            color: #fff;
            font-size: 36px;
            font-weight: 700;
            margin-bottom: 16px;
            letter-spacing: 4px;
        }

        .brand-desc {
            color: rgba(255, 255, 255, 0.7);
            font-size: 16px;
            letter-spacing: 2px;
        }
    }
}

.login-right {
    width: 480px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: #fff;

    .login-box {
        width: 360px;

        .login-title {
            font-size: 28px;
            font-weight: 700;
            color: #1a237e;
            margin-bottom: 8px;
        }

        .login-subtitle {
            font-size: 14px;
            color: #999;
            margin-bottom: 32px;
        }

        .role-group {
            display: flex;
            gap: 16px;
            flex-wrap: wrap;

            .role-item {
                margin-right: 0;
            }
        }

        .login-btn {
            width: 100%;
            height: 44px;
            font-size: 16px;
            letter-spacing: 4px;
            border-radius: 8px;
            background: linear-gradient(135deg, #1a237e, #3949ab);
            border: none;

            &:hover {
                background: linear-gradient(135deg, #283593, #5c6bc0);
            }
        }

        .login-footer {
            text-align: center;
            color: #999;
            font-size: 14px;

            .register-link {
                color: #3949ab;
                text-decoration: none;

                &:hover {
                    text-decoration: underline;
                }
            }
        }
    }
}
</style>
