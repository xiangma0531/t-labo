$(document).on('turbolinks:load', function() {
  $(function() {
    // .tabがクリックされた時を指定
    $('.tab').click(function(){

      // 今の.tab-activeを削除してクリックされた.tabに.tab-activeを追加
      $('.tab-active').removeClass('tab-active');
      $(this).addClass('tab-active');

      // 今の.box-showを削除
      $('.box-show').removeClass('box-show');
      // indexに.tabのindex番号を代入
      const index = $(this).index();
      // .tabboxとindexの番号が同じ要素に.box-showを追加
      $('.tabbox').eq(index).addClass('box-show');
    });
  });
});