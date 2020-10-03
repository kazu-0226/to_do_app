<template>
  <!-- :data= "dataオプションで定義したtoDosオブジェクトでテーブルに表示する -->
  <el-table
    :data= "toDos"
    style= "width: 100%">
    <el-table-column
      prop="finished">
      <!-- v-slotを設定し、それぞれの行のToDoのデータにアクセス -->
      <template v-slot="scope">
        <!-- v-modelディレクティブを使用し、ここにToDoのfinishedカラムを設定 -->
        <!-- el-checkboxにchangeディレクティブを定義してチェックボックスが変更されると、updateToDoメソッドを呼び出す -->
        <el-checkbox
          v-model= "scope.row.finished"
          @change= "updateToDo(scope.row.id, scope.row.finished)" ></el-checkbox>
      </template>
    </el-table-column>
    <el-table-column
      prop= "title">
    </el-table-column>
    <el-table-column
      prop= "expired_at">
    </el-table-column>
    <el-table-column
        width= "120">
    <!-- templateタグでくくって、templateタグにv-slotを指定することで、それぞれのToDoにアクセス -->
    <template v-slot="scope">
    <!-- v-onディレクティブでクリックした時にdestroyToDoメソッドを実行 -->
    <!-- scope.row.idでToDoのデータにアクセス -->
    <el-button
        @click= "destroyToDo(scope.row.id)"
        type= "danger"
        icon= "el-icon-delete"
        circle></el-button>
    </template>
    </el-table-column>
  </el-table>
</template>
<script>
// Vue.jsでAjaxを行うために、app/javascript/to_dos/index.vueでaxiosを利用する
import axios from 'axios'
// lodashのrejectメソッドを利用
import {reject} from 'lodash';
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
  },
  methods: {
  destroyToDo(id) {
    axios.delete('/api/v1/to_dos/' + id)
      .then(res => {
        // レスポンスのHTTPステータスコードが200だった場合
        if (res.status === 200) {
          //rejectメソッドを使用して、削除されたToDo以外のToDoを全て取得し、dataオプションのtoDos
          this.toDos = reject(this.toDos, ['id', id]);
        }
      });
  },
  updateToDo(id, finished) {
  // axiosのpatchメソッドを使用して、updateアクションにリクエスト
  // チェックボックスが変更された時に受け取ったfinishedの情報を渡す
  axios.patch('/api/v1/to_dos/' + id, {to_do: {finished: finished}})
    .then(res => {
      if (res.status === 200) {
        console.log(res)
      }
  })
}
}
}
</script>