// スクロールして表示領域に入ったらclass付与
$(function () {
  $(".inview-fadeIn").on("inview", function () {
    $(this).addClass("is-inview");
  });
  $(".inview-fadeUp").on("inview", function () {
    $(this).addClass("is-inview");
  });
  $(".inview-fadeL").on("inview", function () {
    $(this).addClass("is-inview");
  });
  $(".inview-fadeR").on("inview", function () {
    $(this).addClass("is-inview");
  });
  $(".inview-fadeC").on("inview", function () {
    $(this).addClass("is-inview");
  });
  $(".inview-wipeInL").on("inview", function () {
    $(this).addClass("is-inview");
  });
  $(".inview-wipeInR").on("inview", function () {
    $(this).addClass("is-inview");
  });
  $(".inview-customContainer").on("inview", function () {
    $(this).addClass("is-inview");
  });
});
