import { initCtxData } from '@/api/data'

export default {
  data() {
    return {
      loading: true,
      data: [],
      page: 0,
      size: 10,
      total: 0,
      url: '',
      params: {},
      query: {},
      time: 170,
      isAdd: false,
      base_method: 'GET'
    }
  },
  methods: {
    async init() {
      this.base_content = '/'
      // this.base_method = "GET";
      if (!(await this.beforeInit())) {
        return
      }
      return new Promise((resolve, reject) => {
        this.loading = true
        console.log(this.params)
        initCtxData(
          this.base_content + this.url,
          this.base_method,
          this.params
        )
          .then(res => {
            // this.total = res.totalElements
            // this.data = res.content
            this.endOfInitRequest(res)
            setTimeout(() => {
              this.loading = false
            }, this.time)
            resolve(res)
          })
          .catch(err => {
            this.loading = false
            reject(err)
          })
      })
    },
    beforeInit() {
      return true
    },
    pageChange(e) {
      this.page = e - 1
      this.init()
    },
    sizeChange(e) {
      this.page = 0
      this.size = e
      this.init()
    },
    endOfInitRequest(res) {
      console.log('endOfInit', res)
      if (res.data) {
        this.data = res.data.records
        this.total = res.data.total
        // console.log('endOfInit2', this.data)
      } else if (res.data) {
        if (typeof res.data.result !== 'undefined') {
          console.log(res.data.result, typeof res.data.result)
          this.data = res.data.result
          this.total = res.data.resultTotal
          // console.log('endOfInit3', res.data.result)
        } else if (
          typeof res.data.content !== 'undefined' &&
          typeof res.data.pageable !== 'undefined'
        ) {
          this.data = res.data.content
          this.total = res.data.pageable.total || res.data.totalElements
          // console.log('endOfInit4', res.data.content)
        } else {
          this.data = res.data
          if (this.total) {
            this.total = res.resultTotal
          }
          // console.log('endOfInit5', res.data)
        }
      }
    },
    // 预防删除第二页最后一条数据时，或者多选删除第二页的数据时，页码错误导致请求无数据
    dleChangePage(size) {
      if (size === undefined) {
        size = 1
      }
      if (this.data.length === size && this.page !== 0) {
        this.page = this.page - 1
      }
    },
    toQuery() {
      this.page = 0
      this.init()
    }
  }
}
