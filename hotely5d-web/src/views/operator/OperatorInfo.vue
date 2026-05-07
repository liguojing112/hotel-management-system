<template>
    <div class="page-container">
        <el-card class="box-card">
            <div slot="header" class="clearfix">
                <span>个人信息</span>
            </div>
            <el-form label-position="left" :model="form" label-width="80px">
                <el-form-item label="账号">
                    <el-input disabled v-model="form.username" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="密码">
                    <el-input type="password" placeholder="请输入密码" v-model="form.password" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="姓名">
                    <el-input placeholder="请输入姓名" v-model="form.name" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="性别">
                    <el-select v-model="form.gender" placeholder="请选择">
                        <el-option v-for="item in genderOptions" :key="item.value" :label="item.label" :value="item.value">
                        </el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="手机">
                    <el-input placeholder="请输入手机号" v-model="form.phone" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item>
                    <el-button type="primary" @click="handleModify">修改</el-button>
                </el-form-item>
            </el-form>
        </el-card>
    </div>
</template>

<script>
import { modifyOperatorAPI } from "@/api/operator";
import { mapMutations } from 'vuex'
import { getUserInfoByTokenAPI } from '@/api/system'
export default {
    name: 'OperatorInfo',
    data() {
        return {
            form: {},
            genderOptions: [
                { label: '男', value: 1 },
                { label: '女', value: 2 }
            ],
        };
    },
    async mounted() {
        const result = await getUserInfoByTokenAPI()
        this.form = result.data
    },
    methods: {
        ...mapMutations(['setUser']),
        async handleModify() {
            const res = await modifyOperatorAPI(this.form);
            this.$message({
                message: res.message,
                type: res.flag ? "success" : "error",
            });
            if (res.flag) {
                this.setUser(this.form)
                setTimeout(() => {
                    this.$router.go(0)
                }, 1000);
            }
        },
    },
};
</script>

<style lang="less" scoped>
.page-container {
    width: 600px;
    margin: 20px auto;
}
</style>
