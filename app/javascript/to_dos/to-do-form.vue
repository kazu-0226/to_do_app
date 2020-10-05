<template>
<!-- Ajaxでリクエストを行うためaxiosのpostメソッドでリクエスト先を指定 -->
  <el-form :model= "toDo">
    <el-form-item label="">
      <el-input
        v-model= "toDo.title"
        placeholder="タイトルを入力"
        name= "to_do[title]"></el-input>
    </el-form-item>
    <el-form-item label="">
      <el-date-picker
        type="datetime"
        format="yyyy/MM/dd HH:mm"
        value-format="yyyy/MM/dd HH:mm"
        placeholder="期限を選択"
        v-model= "toDo.expiredAt"
        name= "to_do[expired_at]"></el-date-picker>
    </el-form-item>
    <el-form-item>
      <!-- ボタンToDoコントローラのcreateアクションにリクエスト -->
      <el-button type="primary" @click= "createToDo">登録</el-button>
      <!-- index.vueのcloseDialog -->
      <el-button @click="$emit('close')">キャンセル</el-button>
    </el-form-item>
  </el-form>
</template>

<script>
import axios from 'axios'
 export default {
   data() {
     return {
       toDo: {
         title: '',
         expiredAt: '',
         finished: false
       }
     }
   },
   methods: {
   createToDo() {
    // axiosのpostメソッドを使って、RailsのToDoコントローラのcreateアクションにリクエスト
    axios.post('/api/v1/to_dos', {to_do: {title: this.toDo.title, expired_at: this.toDo.expiredAt}})
    .then(res => {
      switch (res.status) {
        // ToDoの作成が行われた場合は、HTTPステータスコードの201が返る
        case 201:
          // index.vueのaddToDoで作成されたToDoをテーブルに追加（Rails側から返されたToDoのデータ）
          this.$emit('add', res.data)
          // ダイアログを空にする
          this.toDo = {title: '', expiredAt: ''}
          // index.vueのcloseDialog
          this.$emit('close')
          break;
          // 失敗（400が返された場合は、レスポンスのメッセージをコンソールに表示）
        case 400:
          console.log(res.data.message)
          break;
      }
    });
   }
 }
 }
</script>