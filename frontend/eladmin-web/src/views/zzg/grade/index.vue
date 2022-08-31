<template>
  <div class="app-container">
    <el-row :gutter="20">
      <!--侧边部门数据-->
      <el-col :xs="9" :sm="6" :md="5" :lg="4" :xl="4">
        <div class="head-container">
          <el-input
            v-model="grade_name"
            clearable
            size="small"
            placeholder="输入学年名称搜索"
            prefix-icon="el-icon-search"
            class="filter-item"
            @input="getGradeDatas"
          />
        </div>
        <el-tree
          :data="gradeData"
          :load="getGradeDatas"
          :props="defaultProps"
          :expand-on-click-node="false"
          lazy
          @node-click="handleNodeClick"
        />
      </el-col>
      <!--用户数据-->
      <el-col :xs="15" :sm="18" :md="19" :lg="20" :xl="20">
        <!--工具栏-->
        <div class="head-container">
          <div v-if="crud.props.searchToggle">
            <!-- 搜索 -->
            <el-input
              v-model="query.blurry"
              clearable
              size="small"
              placeholder="输入名称或者邮箱搜索"
              style="width: 200px;"
              class="filter-item"
              @keyup.enter.native="crud.toQuery"
            />
            <el-select
              v-model="query.grade_name"
              clearable
              size="small"
              placeholder="学年"
              class="filter-item"
              style="width: 90px"
              @change="crud.toQuery"
            >
              <el-option
                v-for="item in gradeData"
                :key="item.grade_name"
                :label="item.grade_name"
                :value="item.grade_name"
              />
            </el-select>
            <rrOperation />
          </div>
          <crudOperation show="" :permission="permission" />
        </div>
        <!--表单渲染-->
        <el-dialog append-to-body :close-on-click-modal="false" :before-close="crud.cancelCU" :visible.sync="crud.status.cu > 0" :title="crud.status.title" width="500px">
          <el-form ref="form" :inline="true" :model="form" :rules="rules" size="small" label-width="96px">
            <el-form-item label="年级名称" prop="grade_name">
              <el-select
                v-model="form.grade_name"
                clearable
                size="small"
                placeholder="年级名称"
                class="filter-item"
                style="width: 220px"
              >
                <el-option
                  v-for="item in gradeData"
                  :key="item.grade_name"
                  :label="item.grade_name"
                  :value="item.grade_name"
                />
              </el-select>
            </el-form-item>
            <el-form-item label="课程" prop="subject_name">
              <el-input v-model="form.subject_name" style="width: 220px" />
            </el-form-item>
            <el-form-item label="考试方式">
              <el-radio-group v-model="form.test_method" style="width: 178px">
                <el-radio :label="0">开卷</el-radio>
                <el-radio :label="1">闭卷</el-radio>
              </el-radio-group>
            </el-form-item>
            <el-form-item label="是否计入总分">
              <el-radio-group v-model="form.join_total" style="width: 178px">
                <el-radio :label="0">不计</el-radio>
                <el-radio :label="1">计入</el-radio>
              </el-radio-group>
            </el-form-item>
          </el-form>
          <div slot="footer" class="dialog-footer">
            <el-button type="text" @click="crud.cancelCU">取消</el-button>
            <el-button :loading="crud.status.cu === 2" type="primary" @click="crud.submitCU">确认</el-button>
          </div>
        </el-dialog>
        <!--表格渲染-->
        <el-table ref="table" v-loading="crud.loading" :data="crud.data" style="width: 100%;" @selection-change="crud.selectionChangeHandler">
          <el-table-column type="selection" width="55" />
          <el-table-column :show-overflow-tooltip="true" prop="grade_name" label="学年" />
          <el-table-column :show-overflow-tooltip="true" prop="subject_name" label="课程名称" />
          <el-table-column prop="test_method" label="考试方式">
            <template slot-scope="scope">
              {{ scope.row.test_method === 1 ? '闭卷': '开卷' }}
            </template>
          </el-table-column>
          <el-table-column prop="join_total" label="计入总分">
            <template slot-scope="scope">
              {{ scope.row.join_total === 1 ? '计入': '不计' }}
            </template>
          </el-table-column>
          <el-table-column :show-overflow-tooltip="true" prop="create_time" width="135" label="创建日期" />
          <el-table-column
            v-if="checkPer(['admin','user:edit','user:del'])"
            label="操作"
            width="115"
            align="center"
            fixed="right"
          >
            <template slot-scope="scope">
              <udOperation
                :data="scope.row"
                :permission="permission"
                :disabled-dle="scope.row.subject_id === user.subject_id"
              />
            </template>
          </el-table-column>
        </el-table>
        <!--分页组件-->
        <pagination />
      </el-col>
    </el-row>
  </div>
</template>

<script>
import crudGrade from '@/api/zzg/grade'
import { isvalidPhone } from '@/utils/validate'
import { grade } from '@/api/zzg/grade'
import CRUD, { presenter, header, form, crud } from '@crud/crud'
import rrOperation from '@crud/RR.operation'
import crudOperation from '@crud/CRUD.operation'
import udOperation from '@crud/UD.operation'
import pagination from '@crud/Pagination'
import { mapGetters } from 'vuex'
let userRoles = []
let userJobs = []
const defaultForm = { subject_id: null, subject_name: null, grade_name: null, join_total: 0, test_method: 0 }
export default {
  name: 'User',
  components: { crudOperation, rrOperation, udOperation, pagination },
  cruds() {
    return CRUD({ title: '课程', url: 'api/v1/subject/paged', idField: 'subject_id', crudMethod: { ...crudGrade }})
  },
  mixins: [presenter(), header(), form(defaultForm), crud()],
  // 数据字典
  dicts: ['user_status'],
  data() {
    // 自定义验证
    const validPhone = (rule, value, callback) => {
      if (!value) {
        callback(new Error('请输入电话号码'))
      } else if (!isvalidPhone(value)) {
        callback(new Error('请输入正确的11位手机号码'))
      } else {
        callback()
      }
    }
    return {
      height: document.documentElement.clientHeight - 180 + 'px;',
      grade_name: '', gradeData: [],
      defaultProps: { children: 'children', label: 'grade_name', isLeaf: 'leaf' },
      permission: {
        add: ['admin', 'user:add'],
        edit: ['admin', 'user:edit'],
        del: ['admin', 'user:del']
      },
      enabledTypeOptions: [
        { key: 'true', display_name: '激活' },
        { key: 'false', display_name: '锁定' }
      ],
      rules: {
        username: [
          { required: true, message: '请输入用户名', trigger: 'blur' },
          { min: 2, max: 20, message: '长度在 2 到 20 个字符', trigger: 'blur' }
        ],
        nickName: [
          { required: true, message: '请输入用户昵称', trigger: 'blur' },
          { min: 2, max: 20, message: '长度在 2 到 20 个字符', trigger: 'blur' }
        ],
        email: [
          { required: true, message: '请输入邮箱地址', trigger: 'blur' },
          { type: 'email', message: '请输入正确的邮箱地址', trigger: 'blur' }
        ],
        phone: [
          { required: true, trigger: 'blur', validator: validPhone }
        ]
      }
    }
  },
  computed: {
    ...mapGetters([
      'user'
    ])
  },
  created() {
    this.crud.msg.add = ''
  },
  mounted: function() {
    const that = this
    window.onresize = function temp() {
      that.height = document.documentElement.clientHeight - 180 + 'px;'
    }
  },
  methods: {
    // 禁止输入空格
    keydown(e) {
      if (e.keyCode === 32) {
        e.returnValue = false
      }
    },
    handleTreeSelected(d) {
      console.log(d, this.form)
    },
    changeRole(value) {
      userRoles = []
      value.forEach(function(data, index) {
        const role = { role_id: data }
        userRoles.push(role)
      })
    },
    changeJob(value) {
      userJobs = []
      value.forEach(function(data, index) {
        const job = { job_id: data }
        userJobs.push(job)
      })
    },
    deleteTag(value) {
      userRoles.forEach(function(data, index) {
        if (data.id === value) {
          userRoles.splice(index, value)
        }
      })
    },
    // 新增与编辑前做的操作
    [CRUD.HOOK.afterToCU](crud, form) {

    },
    // 新增前将多选的值设置为空
    [CRUD.HOOK.beforeToAdd](crud, form) {
      form = { }
      this.form = { }
    },
    // 初始化编辑时候的角色与岗位
    [CRUD.HOOK.beforeToEdit](crud, form) {
      console.log(crud, form)
      const that = this
      crud.crudMethod.get(form.subject_id).then(res => {
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
      if (!(crud.form.grade_name && crud.form.grade_name !== '')) {
        this.$message({
          message: '学年级不能为空',
          type: 'warning'
        })
        return false
      } else if (!(crud.form.subject_name && crud.form.subject_name !== '')) {
        this.$message({
          message: '课程不能为空',
          type: 'warning'
        })
        return false
      }
      return true
    },
    // 获取左侧部门数据
    getGradeDatas(node, resolve) {
      const sort = 'id,desc'
      const params = { sort: sort }
      if (typeof node !== 'object') {
        if (node) {
          params['name'] = node
        }
      } else if (node.level !== 0) {
        params['pid'] = node.data.id
      }
      setTimeout(() => {
        grade(params).then(res => {
          var datalist = res.data.map(e => {
            e.children = []
            e.leaf = true
            return e
          })
          if (resolve) {
            this.gradeData = datalist
            resolve(datalist)
          } else {
            this.gradeData = datalist
          }
        })
      }, 100)
    },
    // 切换部门
    handleNodeClick(data) {
      if (data.grade_name && data.grade_name !== '') {
        this.query.grade_name = data.grade_name
      } else {
        this.query.grade_name = undefined
      }
      this.crud.toQuery()
    }
  }
}
</script>

<style rel="stylesheet/scss" lang="scss" scoped>
  ::v-deep .vue-treeselect__control,::v-deep .vue-treeselect__placeholder,::v-deep .vue-treeselect__single-value {
    height: 30px;
    line-height: 30px;
  }
</style>
