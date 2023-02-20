$(function(){
  var close = $('.modal-close');
  var container = $('.modal-container');
  var front = $('.front');

  //開く
  front.on('click',function(){
    var id = $(this).children('.id').text();
    $.when(
      $.ajax({
        url: "/movies/tmdb_id",
        type: "POST",
        data: { tmdb_id: id},
        context: this,
        success: function(tmdb_id){
          id = tmdb_id
        },
        error: function(tmdb_id){
        }
      })
    ).done(function() {
      console.log(id)
      var title = $(this).children('.title').text();
      var image = $(this).children('.image').text();
      var overview = $(this).children('.overview').text();
      if (image == "https://image.tmdb.org/t/p/w1280"){
        image = "/images/no_phone.jpg";
      }
      console.log(image);
      if (!overview){
        overview = "詳細不明";
      }
      console.log(title)
      $(container).find('img').attr('src', image);
      $(container).find('h5').text(title);
      $(container).find('p').text(overview);
      $(container).find('a').attr("href", "movies/" + id)

      container.addClass('active');
      return false;
    });
  });

  //×ボタンで閉じる
  close.on('click',function(){
    container.removeClass('active');
  });

  //画面外をクリックしたら閉じる
  $(document).on('click',function(e) {
    if(!$(e.target).closest('.modal-body').length) {
      container.removeClass('active');
    }
  });
});