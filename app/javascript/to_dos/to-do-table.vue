<template>
  <el-table
    :data= "toDos"
    style="width: 100%">
    <el-table-column
      prop="finished">
      <template v-slot= "scope">
        <!-- $emitメソッドでindex.vueから受け取ったメソッドをto-do-table.vueで呼び出す -->
        <!-- 第一引数updateでupdateToDoメソッドを呼び出し、それ以降の引数は、updateイベントにidとfinishedの値を渡す -->
        <el-checkbox
          v-model= "scope.row.finished"
          @change= "$emit('update', scope.row.id, scope.row.finished)"></el-checkbox>
      </template>
    </el-table-column>
    <el-table-column
      prop="title">
    </el-table-column>
    <el-table-column
      prop="expired_at">
    </el-table-column>
    <el-table-column width= "120">
    <template v-slot= "scope">
      <!-- 第一引数destroyでdestroyToDoメソッドを呼び出し、それ以降の引数は、destroyベントにidの値を渡す -->
      <el-button
        @click= "$emit('destroy', scope.row.id)"
        type="danger"
        icon="el-icon-delete"
        circle>
      </el-button>
    </template>
    </el-table-column>
  </el-table>
</template>

<script>
// テーブルに表示するtoDosデータをindex.vueから受け取る
  export default {
    props: ['toDos'] 
  }

</script>