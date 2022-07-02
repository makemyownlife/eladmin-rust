<template>
  <el-dialog
    :visible.sync="dialog"
    :close-on-click-modal="false"
    :before-close="cancel"
    :title="isAdd ? '新增权限' : '编辑权限'"
    append-to-body
    class="base_modal"
    width="525px"
  >
    <el-form
      ref="form"
      :model="form"
      :rules="rules"
      size="small"
      label-width="100px"
    >
      <el-form-item
        label="名称"
        prop="name"
      >
        <el-input
          v-model="form.name"
          style="width: 360px;"
        />
      </el-form-item>
      <el-form-item
        label="别名"
        prop="alias"
      >
        <el-input
          v-model="form.alias"
          style="width: 360px;"
        />
      </el-form-item>
      <el-form-item
        label="微服务ID"
        prop="service_id"
      >
        <el-input
          v-model="form.service_id"
          style="width: 360px;"
        />
      </el-form-item>
      <el-form-item
        label="API路径模式"
        prop="api_pattern"
      >
        <el-input
          v-model="form.api_pattern"
          style="width: 360px;"
        />
      </el-form-item>
      <el-form-item
        label="API请求方法"
        prop="api_method"
      >
        <el-input
          v-model="form.api_method"
          style="width: 360px;"
        />
      </el-form-item>
      <el-form-item
        label="授权方式"
        prop="api_bypass"
      >
        <el-select
          v-model="form.api_bypass"
          style="width: 178px"
          placeholder="请选择"
        >
          <el-option
            v-for="item in BypassOptions"
            :key="item.value"
            :label="item.label"
            :value="item.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item
        style="margin-bottom: 0px;"
        label="上级类目"
      >
        <treeselect
          v-model="form.pid"
          lazy
          :options="permissions"
          :load-options="loadSubPermission"
          style="width: 360px;"
          placeholder="选择上级类目"
        />
      </el-form-item>
    </el-form>
    <div
      slot="footer"
      class="dialog-footer"
    >
      <el-button
        type="text"
        @click="cancel"
      >取消</el-button>
      <el-button
        :loading="loading"
        type="primary"
        @click="doSubmit"
      >确认</el-button>
    </div>
  </el-dialog>
</template>

<script>
import { add, edit, querySubPermissions } from '@/api/system/permission'
import { LOAD_CHILDREN_OPTIONS } from '@riophae/vue-treeselect'
import Treeselect from '@riophae/vue-treeselect'
import '@riophae/vue-treeselect/dist/vue-treeselect.css'
export default {
  components: { Treeselect },
  props: {
    isAdd: {
      type: Boolean,
      required: true
    }
  },
  data() {
    return {
      loading: false, dialog: false, permissions: [],
      form: { name: '', alias: '', serviceId: '', apiPattern: '', apiMethod: '', apiBypass: false, pid: 0 },
      BypassOptions: [
        { label: '授权', value: 'permitted' },
        { label: '登录', value: 'user' },
        { label: '匿名', value: 'anonymous' }
      ],
      rules: {
        name: [
          { required: true, message: '请输入名称', trigger: 'blur' }
        ],
        alias: [
          { required: true, message: '请输入别名', trigger: 'blur' }
        ],
        serviceId: [
          { required: true, message: '请输入微服务ID', trigger: 'blur' }
        ],
        apiPattern: [
          { required: true, message: '请输入API路径模式', trigger: 'blur' }
        ],
        apiMethod: [
          { required: true, message: '请输入API请求方法', trigger: 'blur' }
        ]
      }
    }
  },
  mounted() {
    this.getPermissions()
  },
  methods: {
    cancel() {
      this.resetForm()
    },
    doSubmit() {
      this.$refs['form'].validate((valid) => {
        if (valid) {
          this.loading = true
          if (this.isAdd) {
            this.doAdd()
          } else this.doEdit()
        } else {
          return false
        }
      })
    },
    doAdd() {
      add(this.form).then(res => {
        this.resetForm()
        this.$notify({
          title: '添加成功',
          type: 'success',
          duration: 2500
        })
        this.loading = false
        this.$parent.init()
      }).catch(err => {
        this.loading = false
        console.log(err.response.data.message)
      })
    },
    doEdit() {
      edit(this.form).then(res => {
        this.resetForm()
        this.$notify({
          title: '修改成功',
          type: 'success',
          duration: 2500
        })
        this.loading = false
        this.$parent.init()
      }).catch(err => {
        this.loading = false
        console.log(err.response.data.message)
      })
    },
    resetForm() {
      this.dialog = false
      this.$refs['form'].resetFields()
      this.form = { name: '', alias: '', serviceId: '', apiPattern: '', apiMethod: '', apiBypass: false, pid: 0 }
    },
    getPermissions() {
      querySubPermissions(0).then(res => {
        this.permissions = []
        const permission = { id: 0, label: '顶级类目', children: [] }
        permission.children = res.data.map(r => {
          r.children = null
          return r
        })
        this.permissions.push(permission)
      })
    },
    loadSubPermission({ action, parentNode, callback }) {
      if (action === LOAD_CHILDREN_OPTIONS) {
        querySubPermissions(parentNode.id).then(res => {
          parentNode.children = res.data.map(r => {
            r.children = null
            return r
          })
          callback()
        }).catch(_ => {
          callback()
        })
      }
    }
  }
}
</script>

<style scoped>
.el-form-item .el-form-item__label {
  width: 160px;
}
</style>
