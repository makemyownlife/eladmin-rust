<template>
  <div class="app-container">
    <div class="boxoutside">
      <!--工具栏-->
      <div class="head-container">
        <!-- 搜索 -->
        <el-input
          v-model="query.value"
          clearable
          placeholder="输入名称或者别名搜索"
          style="width: 200px;"
          class="filter-item"
          @keyup.enter.native="toQuery"
        />
        <!-- 搜索 -->
        <el-input
          v-model="query.pattern"
          clearable
          placeholder="输入路径模式搜索"
          style="width: 400px;"
          class="filter-item"
          @keyup.enter.native="toQuery"
        />
        <el-button
          class="filter-item pdbtn"
          size="mini"
          type="success"
          icon="el-icon-search"
          @click="toQuery"
        >搜索</el-button>
        <!-- 新增 -->
        <div style="display: inline-block;">
          <el-button
            class="filter-item pdbtn"
            size="mini"
            type="primary"
            icon="el-icon-plus"
            @click="add"
          >新增</el-button>
        </div>
        <div style="display: inline-block;">
          <el-button
            class="filter-item pdbtn"
            size="mini"
            type="warning"
            icon="el-icon-more"
            @click="changeExpand"
          >{{ expand ? '折叠' : '展开' }}</el-button>
          <eForm
            ref="form"
            :is-add="true"
          />
        </div>
      </div>
      <!--表单组件-->
      <eForm
        ref="form"
        :is-add="isAdd"
      />
      <!--表格渲染-->
      <!-- :height="height" -->
      <el-table
        v-loading="loading"
        lazy
        :data="data"
        :expand-all="expand"
        :load="getCurRowChildren"
        :tree-props="{children: 'children', hasChildren: 'has_children'}"
        row-key="id"
        :children-get-func="getCurRowChildren"
        size="small"
      >
        <el-table-column
          :show-overflow-tooltip="true"
          label="名称"
          align="left"
          width="180px"
        >
          <template slot-scope="scope">
            <span>{{ scope.row.name }}</span>
          </template>
        </el-table-column>
        <el-table-column
          :show-overflow-tooltip="true"
          label="别名"
          align="left"
          width="180px"
        >
          <template slot-scope="scope">
            <span>{{ scope.row.alias }}</span>
          </template>
        </el-table-column>
        <el-table-column
          :show-overflow-tooltip="true"
          label="微服务ID"
          align="left"
          width="120px"
        >
          <template slot-scope="scope">
            <span>{{ scope.row.service_id }}</span>
          </template>
        </el-table-column>
        <el-table-column
          :show-overflow-tooltip="true"
          label="路径模式"
          align="center"
        >
          <template slot-scope="scope">
            <span>{{ scope.row.api_pattern }}</span>
          </template>
        </el-table-column>
        <el-table-column
          label="请求方法"
          width="100px"
          align="left"
        >
          <template slot-scope="scope">
            <span>{{ scope.row.api_method }}</span>
          </template>
        </el-table-column>
        <el-table-column
          label="授权方式"
          width="100px"
          align="left"
        >
          <template slot-scope="scope">
            <span>{{ scope.row.api_bypass }}</span>
          </template>
        </el-table-column>
        <el-table-column
          label="操作"
          width="180px"
          align="center"
        >
          <template slot-scope="scope">
            <el-tooltip
              class="item"
              effect="dark"
              content="编辑"
              placement="top"
            >
              <el-button
                type="primary"
                icon="el-icon-edit"
                style="margin-left: 0"
                @click="edit(scope.row)"
              />
            </el-tooltip>
            <el-tooltip
              v-if="false"
              class="item"
              effect="dark"
              content="查看角色"
              placement="top"
            >
              <el-button
                size="mini"
                icon="el-icon-reading"
                type="success"
                style="  margin-left: 10px"
                @click="showRoles(scope.row)"
              />
            </el-tooltip>
            <!-- <el-button
            v-permission="['ADMIN','ACBASE_PERMISSION']"
            size="mini"
            type="primary"
            icon="el-icon-reading"
            style=" margin-left: 0"
            @click="showRoles(scope.row)">查看角色</el-button> -->
            <el-tooltip
              class="item"
              effect="dark"
              content="删除"
              placement="top"
            >

              <el-popover
                :ref="scope.row.id"
                placement="top"
                width="200"
              >
                <p>确定删除吗,如果存在下级节点则一并删除，此操作不能撤销！</p>
                <div style="text-align: right; margin: 0">
                  <el-button
                    size="mini"
                    type="text"
                    @click="$refs[scope.row.id].doClose()"
                  >取消</el-button>
                  <el-button
                    :loading="delLoading"
                    type="primary"
                    size="mini"
                    @click="subDelete(scope.row.id)"
                  >确定</el-button>
                </div>
                <!-- <el-button
              slot="reference"
              type="danger"
              icon="el-icon-delete"
              size="mini" /> -->

                <el-button
                  slot="reference"
                  type="danger"
                  icon="el-icon-delete"
                  size="mini"
                  style=" margin-left: 10px"
                />
              </el-popover>
            </el-tooltip>
          </template>
        </el-table-column>
      </el-table>
      <!--分页组件-->
      <el-pagination
        :total="total"
        :current-page="page+1"
        :page-sizes="[10, 20, 50]"
        style="margin-top: 8px"
        layout="total, prev, pager, next, sizes, jumper"
        @size-change="sizeChange"
        @current-change="pageChange"
      />
      <el-dialog
        :visible="roleVisible"
        :modal="false"
        title="此权限允许访问的角色组"
        custom-class="hidden-cert"
        width="30%"
        @close="roleVisible = false"
      >
        <div v-if="initRoles.length > 0">
          <el-select
            v-model="initRoles"
            disabled
            multiple
            style="width: 100%"
          >
            <el-option
              v-for="(item, index) in roles"
              :key="item.id + index"
              :label="item.name"
              :value="item.id"
            />
          </el-select>
        </div>
        <div v-else>暂无数据</div>
      </el-dialog>
    </div>

  </div>
</template>
<script>
import initData from '@/mixins/initData'
import { del, showRoles, querySubPermissions } from '@/api/system/permission'
import { parseTime } from '@/utils/index'
import eForm from './form'
export default {
  name: 'Permission',
  components: { eForm },
  mixins: [initData],
  data() {
    return {
      delLoading: false, expand: false,
      height: 625,
      roleVisible: false, roles: [], initRoles: []
    }
  },
  created() {
    this.$nextTick(() => {
      this.height = document.documentElement.clientHeight - 200
      this.init()
    })
  },
  methods: {
    parseTime,
    beforeInit() {
      this.data = []
      this.url = 'api/v1/permission/paged'
      this.base_method = 'post'
      const sort = 'id,desc'
      const query = this.query
      const value = query.value
      const pattern = query.pattern
      this.params = { page: this.page, size: this.size, sort: sort, expand: this.expand }
      if (value) { this.params['blurry'] = value }
      if (pattern) { this.params['pattern'] = pattern }
      return true
    },
    subDelete(id) {
      this.delLoading = true
      del(id).then(res => {
        this.delLoading = false
        this.$refs[id].doClose()
        this.init()
        this.$notify({
          title: '删除成功',
          type: 'success',
          duration: 2500
        })
      }).catch(err => {
        this.delLoading = false
        this.$refs[id].doClose()
        console.log(err.response.data.message)
      })
    },
    add() {
      this.isAdd = true
      // this.$refs.form.getPermissions()
      this.$refs.form.dialog = true
    },
    edit(data) {
      this.isAdd = false
      const _this = this.$refs.form
      // _this.getPermissions()
      _this.form = { id: data.id, name: data.name, alias: data.alias, service_id: data.service_id, api_pattern: data.api_pattern, api_method: data.api_method, api_bypass: data.api_bypass, pid: data.pid }
      _this.dialog = true
    },
    changeExpand() {
      this.expand = !this.expand
      this.init()
    },
    showRoles(data) {
      showRoles(data.id).then(dt => {
        this.roleVisible = true
        if (dt.length > 0) {
          this.roles = dt
          this.initRoles = dt.flatMap(e => {
            return e.id
          })
        }
      })
    },
    getCurRowChildren(record, pn, callback) {
      console.log('Load: ', record, pn, callback)
      if (!record) {
        return
      }
      querySubPermissions(record.id).then(res => {
        console.log('Permission', res)
        callback(res.data)
      })
    }
  }
}
</script>

<style scoped>
.hidden-cert i.el-select__caret {
    /*很关键：将默认的select选择框样式清除*/
    appearance: none;
    -moz-appearance: none;
    -webkit-appearance: none;
    display: none;
}

</style>
