<template>
  <div class="app-container">
    <!--工具栏-->
    <div class="head-container">
      <div>
        <!-- 搜索 -->
        <el-input v-model="query.label" clearable size="small" placeholder="输入字典标签查询" style="width: 200px;" class="filter-item" @keyup.enter.native="toQuery" />
        <rrOperation />
      </div>
      <el-button
        class="filter-item"
        size="mini"
        style="float: right;padding: 4px 10px"
        type="primary"
        icon="el-icon-plus"
        @click="crud.toAdd()"
      >新增</el-button>
    </div>
    <!--表单组件-->
    <el-dialog append-to-body :close-on-click-modal="false" :before-close="crud.cancelCU" :visible="crud.status.cu > 0" :title="crud.status.title" width="500px">
      <el-form ref="form" :model="form" :rules="rules" size="small" label-width="96px">
        <el-form-item label="兑换名称" prop="exchange_name">
          <el-input v-model="form.exchange_name" style="width: 370px;" />
        </el-form-item>
        <el-form-item label="详细描述" prop="exchange_desc">
          <el-input v-model="form.exchange_desc" type="textarea" style="width: 370px;" />
        </el-form-item>
        <el-form-item label="花费分数" prop="used_point">
          <el-input v-model="form.used_point" style="width: 370px;" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="text" @click="crud.cancelCU">取消</el-button>
        <el-button :loading="crud.status.cu === 2" type="primary" @click="crud.submitCU">确认</el-button>
      </div>
    </el-dialog>
    <!--表格渲染-->
    <el-table ref="table" v-loading="crud.loading" :data="crud.data" highlight-current-row style="width: 100%;" @selection-change="crud.selectionChangeHandler">
      <el-table-column prop="tmpl_id" label="ID" width="120" />
      <el-table-column prop="exchange_name" label="兑换名称" width="280" />
      <el-table-column prop="exchange_desc" label="描述" />
      <el-table-column prop="used_point" label="花费积分" width="100" />
      <el-table-column v-if="checkPer(['admin','dict:edit','dict:del'])" label="操作" width="130px" align="center" fixed="right">
        <template slot-scope="scope">
          <udOperation
            :data="scope.row"
            :permission="permission"
          />
        </template>
      </el-table-column>
    </el-table>
    <!--分页组件-->
    <pagination />
  </div>
</template>

<script>
import crudExchange from '@/api/zzg/exchange'
import CRUD, { presenter, header, form } from '@crud/crud'
import pagination from '@crud/Pagination'
import rrOperation from '@crud/RR.operation'
import udOperation from '@crud/UD.operation'

const defaultForm = { }

export default {
  components: { pagination, rrOperation, udOperation },
  mixins: [
    presenter(),
    header(),
    form(function() {
      return Object.assign({ category_id: this.category_id, ...defaultForm })
    })],
  cruds() {
    return [
      CRUD({ title: '积分行为模板', url: 'api/v1/exchange_tmpl/paged', query: { exchange_name: '' }, idField: 'tmpl_id', sort: ['exchange_name, asc'],
        crudMethod: { ...crudExchange },
        optShow: {
          add: true,
          edit: true,
          del: true,
          reset: false
        },
        queryOnPresenterCreated: true
      })
    ]
  },
  data() {
    return {
      point_template_id: null,
      rules: {
        exchange_name: [
          { required: true, message: '请输入兑换名称', trigger: 'blur' }
        ],
        exchange_desc: [
          { required: true, message: '请输入兑换描述', trigger: 'blur' }
        ]
      },
      permission: {
        add: ['admin', 'behavior:add'],
        edit: ['admin', 'behavior:edit'],
        del: ['admin', 'behavior:del']
      }
    }
  },
  methods: {
    [CRUD.HOOK.beforeToAdd](crud, form) {
      form = { ...form, exchange_name: '', exchange_desc: '', used_point: '' }
      this.form = { ...form, exchange_name: '', exchange_desc: '', used_point: '' }
    },
    [CRUD.HOOK.beforeToEdit](crud, form) {
      console.log(crud, form)
      const that = this
      crud.crudMethod.get(form.tmpl_id).then(res => {
        console.log(res)
        if (res.status === 200) {
          form = { ...res.data }
          that.form = form
        }
      })
    },
    // 提交前做的操作
    [CRUD.HOOK.afterValidateCU](crud) {
      crud.form = this.form
      if (!(crud.form.exchange_name && crud.form.exchange_name !== '')) {
        this.$message({
          message: '分类不能为空',
          type: 'warning'
        })
        return false
      } else if (!(crud.form.exchange_desc && crud.form.exchange_desc !== '')) {
        this.$message({
          message: '详细描述不能为空',
          type: 'warning'
        })
        return false
      }
      return true
    }
  }
}
</script>

<style rel="stylesheet/scss" lang="scss" scoped>
 ::v-deep .el-input-number .el-input__inner {
    text-align: left;
  }
</style>
