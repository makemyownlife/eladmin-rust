<template>
  <div>
    <div v-if="query.category_id === ''">
      <div class="my-code">点击积分分类查看详情</div>
    </div>
    <div v-else>
      <!--工具栏-->
      <div class="head-container">
        <div v-if="crud.props.searchToggle">
          <!-- 搜索 -->
          <el-input v-model="query.label" clearable size="small" placeholder="输入字典标签查询" style="width: 200px;" class="filter-item" @keyup.enter.native="toQuery" />
          <rrOperation />
        </div>
      </div>
      <!--表单组件-->
      <el-dialog append-to-body :close-on-click-modal="false" :before-close="crud.cancelCU" :visible="crud.status.cu > 0" :title="crud.status.title" width="500px">
        <el-form ref="form" :model="form" :rules="rules" size="small" label-width="96px">
          <el-form-item label="分类" prop="category_id">
            <el-select
              v-model="form.category_id"
              clearable
              size="small"
              placeholder="分类"
              class="filter-item"
              style="width: 370px"
            >
              <el-option
                v-for="item in categoryList"
                :key="item.category_id"
                :label="item.category_id"
                :value="item.category_id"
              />
            </el-select>
          </el-form-item>
          <el-form-item label="详细描述" prop="description">
            <el-input v-model="form.description" type="textarea" style="width: 370px;" />
          </el-form-item>
          <el-form-item label="分级" prop="grading">
            <el-switch v-model="form.grading" style="width: 370px;" />
          </el-form-item>
          <el-form-item label="完成分" prop="normal_point">
            <el-input v-model="form.normal_point" style="width: 370px;" />
          </el-form-item>
          <el-form-item v-if="form.grading" label="良好分" prop="good_point">
            <el-input v-model="form.good_point" style="width: 370px;" />
          </el-form-item>
          <el-form-item v-if="form.grading" label="优秀分" prop="best_point">
            <el-input v-model="form.best_point" style="width: 370px;" />
          </el-form-item>
          <el-form-item label="需上传图片" prop="upload_picture">
            <el-switch v-model="form.upload_picture" />
          </el-form-item>
          <el-form-item label="需上传视频" prop="upload_video">
            <el-switch v-model="form.upload_video" />
          </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
          <el-button type="text" @click="crud.cancelCU">取消</el-button>
          <el-button :loading="crud.status.cu === 2" type="primary" @click="crud.submitCU">确认</el-button>
        </div>
      </el-dialog>
      <!--表格渲染-->
      <el-table ref="table" v-loading="crud.loading" :data="crud.data" highlight-current-row style="width: 100%;" @selection-change="crud.selectionChangeHandler">
        <el-table-column prop="category_id" label="分类" width="120" />
        <el-table-column prop="description" label="描述" />
        <el-table-column prop="grading" label="分级" width="60">
          <template slot-scope="scope">
            {{ scope.row.grading ? '分级' : '不分' }}
          </template>
        </el-table-column>
        <el-table-column prop="normal_point" label="完成分" width="60" />
        <el-table-column prop="good_point" label="良好分" width="60" />
        <el-table-column prop="best_point" label="优秀分" width="60" />
        <el-table-column prop="negative" label="扣分项" width="60">
          <template slot-scope="scope">
            {{ scope.row.negative ? '扣分' : '' }}
          </template>
        </el-table-column>
        <el-table-column prop="negative" label="需上传" width="80">
          <template slot-scope="scope">
            {{ scope.row.upload_picture && scope.row.upload_video ? '图片/视频' : (scope.row.upload_video ? '视频': (scope.row.upload_video? '图片': '')) }}
          </template>
        </el-table-column>
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
  </div>
</template>

<script>
import crudBehaviors from '@/api/zzg/behaviors'
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
  props: {
    categoryList: {
      type: Array,
      requires: true,
      defaultValue: []
    }
  },
  cruds() {
    return [
      CRUD({ title: '积分行为模板', url: 'api/v1/template/paged', query: { category_id: '' }, idField: 'point_template_id', sort: ['category_id, asc'],
        crudMethod: { ...crudBehaviors },
        optShow: {
          add: true,
          edit: true,
          del: true,
          reset: false
        },
        queryOnPresenterCreated: false
      })
    ]
  },
  data() {
    return {
      point_template_id: null,
      rules: {
        category_id: [
          { required: true, message: '请输入分类ID', trigger: 'blur' }
        ],
        description: [
          { required: true, message: '请输入分类描述', trigger: 'blur' }
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
      form = { ...form, description: '', good_point: 0, best_point: 0, normal_point: 0, upload_picture: false, upload_video: false, grading: false }
      this.form = { ...form, description: '', good_point: 0, best_point: 0, normal_point: 0, upload_picture: false, upload_video: false, grading: false }
    },
    [CRUD.HOOK.beforeToEdit](crud, form) {
      console.log(crud, form)
      const that = this
      crud.crudMethod.get(form.point_template_id).then(res => {
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
      if (!(crud.form.category_id && crud.form.category_id !== '')) {
        this.$message({
          message: '分类不能为空',
          type: 'warning'
        })
        return false
      } else if (!(crud.form.description && crud.form.description !== '')) {
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
