<template>
  <div class="app-container">
    <el-card class="box-table">
      <el-form :inline="true" class="demo-form-inline" :model="searchForm">
        <el-form-item label="景区名称">
          <el-input placeholder="请输入景区名称" v-model="searchForm.cityName"></el-input>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleSearch">查询</el-button>
          <el-button @click="handleAdd">新增</el-button>
        </el-form-item>
      </el-form>
      <el-table v-loading="listLoading" :data="list" element-loading-text="Loading" border fit highlight-current-row
        size="small">
        <el-table-column align="center" label="ID" prop="id"></el-table-column>
        <el-table-column align="center" label="景区名称" prop="cityName"></el-table-column>
        <el-table-column align="center" label="纬度" prop="lat"></el-table-column>
        <el-table-column align="center" label="经度" prop="lng"></el-table-column>
        <el-table-column fixed="right" label="操作" width="200">
          <template slot-scope="scope">
            <el-button @click="handleEdit(scope.row)" type="text" size="small">编辑</el-button>
            <el-popconfirm title="确定删除吗？" @confirm="deleteConfirm(scope.row)">
              <el-button type="text" slot="reference" size="small">删除</el-button>
            </el-popconfirm>
          </template>
        </el-table-column>
      </el-table>
      <el-pagination class="page-box" background @size-change="handleSizeChange" @current-change="handleCurrentChange"
        :current-page="pageNum" :page-sizes="[10, 20]" :page-size="pageSize"
        layout="total, sizes, prev, pager, next, jumper" :total="total">
      </el-pagination>
    </el-card>
    <el-dialog :title="dialogTitle" :visible.sync="dialogFormVisible">
      <el-form label-position="left" :model="dialogForm" label-width="80px">
        <el-form-item label="景区名称">
          <el-input placeholder="请输入景区名称" v-model="dialogForm.cityName" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="纬度">
          <el-input placeholder="请输入纬度" v-model="dialogForm.lat" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="经度">
          <el-input placeholder="请输入经度" v-model="dialogForm.lng" autocomplete="off"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="dialogConfirm">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import {
  findScenicSpotPageAPI,
  addScenicSpotAPI,
  modifyScenicSpotAPI,
  removeScenicSpotAPI,
} from "@/api/scenic-spot";

export default {
  data() {
    return {
      list: null,
      listLoading: true,
      pageSize: 10,
      pageNum: 1,
      total: 0,
      searchForm: {},
      dialogTitle: "添加",
      dialogFormVisible: false,
      dialogForm: {},
    };
  },
  created() {
    this.fetchData();
  },
  methods: {
    handleSizeChange(val) {
      this.pageSize = val;
      this.fetchData();
    },
    handleCurrentChange(val) {
      this.pageNum = val;
      this.fetchData();
    },
    handleSearch() {
      this.fetchData();
    },
    async fetchData() {
      this.listLoading = true;
      let response = await findScenicSpotPageAPI(
        this.pageNum,
        this.pageSize,
        this.searchForm
      );
      this.list = response.data.records;
      this.total = response.data.total;
      this.listLoading = false;
    },
    handleAdd() {
      this.dialogTitle = "新增";
      this.dialogFormVisible = true;
      this.dialogForm = {};
    },
    handleEdit(row) {
      this.dialogTitle = "修改";
      this.dialogFormVisible = true;
      this.dialogForm = { ...row };
    },
    async dialogConfirm() {
      let res = null;
      if (this.dialogTitle == "新增") {
        res = await addScenicSpotAPI(this.dialogForm);
      } else {
        res = await modifyScenicSpotAPI(this.dialogForm);
      }
      if (res.flag) {
        this.dialogFormVisible = false;
      }
      this.$message({
        message: res.message,
        type: res.flag ? "success" : "error",
      });
      this.fetchData();
    },
    async deleteConfirm(row) {
      this.pageNum = 1;
      const res = await removeScenicSpotAPI(row.id);
      this.$message({
        message: res.message,
        type: res.flag ? "success" : "error",
      });
      this.fetchData();
    },
  },
};
</script>

<style lang="less" scoped>
.page-box {
  margin-top: 20px;
}
</style>
