<template>
<!-- cell-dblclick（Element UIのイベント）を利用してダブルクリックの処理を追加 -->
  <el-table
    :data= "toDos"
    style="width: 100%"
    @cell-dblclick= "showInput">
    <el-table-column
      prop="finished">
      <template v-slot= "scope">
        <!-- $emitメソッドでindex.vueから受け取ったメソッドをto-do-table.vueで呼び出す -->
        <!-- 第一引数updateでupdateToDoメソッドを呼び出し、それ以降の引数は、updateイベントにidとfinishedの値を渡す -->
        <el-checkbox
          v-model= "scope.row.finished"
          @change= "$emit('update', scope.row)"></el-checkbox>
      </template>
    </el-table-column>
    <el-table-column
      prop="title">
      <template v-slot= "scope">
       <div>{{ scope.row.title }}</div>
       <!-- inputタグにhiddenクラスを与える -->
       <!-- inputタグのフォーカスが外れた場合にindex.vueのupdateToDoメソッドと、hideInputメソッドを呼び出す -->
       <!-- v-onディテクティブ（@としている部分）で複数のメソッドを呼び出したいため、メソッド名をセミコロン（;）で区切って指定 -->
       <el-input
         class= "hidden"
         v-model= "scope.row.title"
         @blur= "$emit('update', scope.row); hideInput($event.target.parentNode)"></el-input>
     </template>
    </el-table-column>
    <el-table-column
      prop="expired_at">
      <template slot-scope="scope">
        <div>{{ scope.row.expired_at }}</div>
        <!-- inputタグにhiddenクラスを与える -->
        <el-date-picker
          type="datetime"
          format="yyyy/MM/dd HH:mm"
          value-format="yyyy/MM/dd HH:mm"
          class="hidden"
          v-model= "scope.row.expired_at"
          @blur= "$emit('update', scope.row); hideInput($event.$el)">
        </el-date-picker>
      </template>
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
    props: ['toDos'],
    methods: {
      showInput(row, column, cell, event) {
        // cell-dbclickイベントは全てのセルに適用されているため、引数のcolumnにはpropertyからはel-table-columnタグのpropに設定した値を指定して
        // その値がtitleもしくexpired_atの場合のみ、ダブルクリックされたときにinputタグを表示
        if (column.property === 'title' || column.property === 'expired_at') {
          // firstElementChildメソッドによって最初の子要素が取得
          let children = cell.firstElementChild.children
          // childrenに含まれている最初の要素にhiddenクラスを付与 = titleのテキストを非表示
          children[0].classList.add('hidden')
          // childrenの２番目の要素からhiddenクラスを削除 = hiddenにしていたinoput要素を表示
          children[1].classList.remove('hidden')

          // childrenの２番目の要素の最初の子要素を取得（inoputタグ）
          let input = children[1].firstElementChild
          // inputをフォーカス
          input.focus()
        }
      },
      // hideInputメソッドで、inputタグを非表示にして、タイトルのテキストを表示
      hideInput(target) {
      // hidden要素をadd
      target.classList.add('hidden')
      // タイトルのテキストを表示している要素(非表示にした要素の兄弟要素)からhiddenクラスを取り除く
      target.previousElementSibling.classList.remove('hidden')
      }
    }
  }

</script>
