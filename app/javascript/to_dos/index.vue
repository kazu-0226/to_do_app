<template>
  <el-table
    :data= "toDos"
    style= "width: 100%">
    <el-table-column
      prop= "title">
    </el-table-column>
    <el-table-column
      prop= "expired_at">
    </el-table-column>
  </el-table>
</template>
<script>
// Vue.jsでAjaxを行うために、app/javascript/to_dos/index.vueでaxiosを利用する
import axios from 'axios'
  export default {
// dataオプションでtoDosオブジェクトを定義しその値を空の配列に
  data() {
    return {
      toDos: []
    }
  },
  created() {
    // にcreatedフックを定義して、axiosを使ってGETリクエストを行う
    axios.get('/api/v1/to_dos')
        // thenメソッドは、axiosでAjax通信に成功した場合に行う処理
        // resにはGETリクエストから受け取ったレスポンス
       .then(res => {
         this.toDos = res.data
       })
  }
}
</script>