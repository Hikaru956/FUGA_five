$(function()
{
    /* スタイルギャラリー */
    new function() {
        /* 設定 */
        var delay    = 1000;
        var interval = 5000;
        var duration =  300;

        /* 初期設定 */
        var pos = 0;
        var tar = $('#fn-gallery-w');
        var gal = $('#fn-gallery-w-box');
        var ull = $('#fn-gallery-w-photo');
        var len = ull.children('li').length;
        var nav = $('#fn-gallery-w-nav');

        if (len > 1){

            /* nav作成 */
            for (let i = 0; i < len; i++) {
                if (i == 0){
                    $('<li class="cur"></li>').appendTo('#fn-gallery-w-nav');
                }else{
                    $('<li></li>').appendTo('#fn-gallery-w-nav');
                }
            }

            /* 表示領域幅変更時実行 */
            var width;
            var resize = function(){
                width = gal.width();
                ull.width(width * (len + 1));
                ull.children('li').width(width);
                pos = 0;
                nav.children('li').removeClass('cur');
                ull.stop(true).animate({'left': 0}, duration);
                nav.children('li').eq(pos).addClass('cur');
            }
            resize();

            /* クローン作成 */
            ull.children('li:eq(0)').clone().appendTo('#fn-gallery-w-photo');

            /* タイマー設定 */
            var intervalID, timerID;
            var start = function(){
                intervalID = setInterval(nexting, interval);
            }
            timerID = setTimeout(start, delay);

            /* 次の画像を表示 */
            var nexting = function(){
                var left;
                ull.stop(true);
                left = ++pos * -width;
                ull.animate({'left': left}, duration, function(){
                    nav.children('li').removeClass('cur');
                    if (pos >= len){
                        pos = 0;
                        ull.css('left', '0');
                    }
                    nav.children('li').eq(pos).addClass('cur');
                });
            }

            /* 次の画像を表示 */
            var next = function(){
                clearTimeout(timerID);
                clearInterval(intervalID);
                nexting();
                timerID = setTimeout(start, delay);
            }

            /* navをクリック */
            nav.children('li').click(function(){
                pos = $(this).index();
                var left;
                ull.stop(true);
                left = pos * -width;
                nav.children('li').removeClass('cur');
                ull.animate({'left': left}, duration);
                nav.children('li').eq(pos).addClass('cur');
            });

            /* イベント：表示領域変更検知 */
            var event_timer = false;
            $(window).resize(function(){
                if (event_timer !== false){
                    clearTimeout(event_timer);
                }
                event_timer = setTimeout(function(){
                    resize();
                    clearTimeout(timerID);
                    clearInterval(intervalID);
                    timerID = setTimeout(start, delay);
                }, 200);
            });

        }
    }

    /* スタイルギャラリー */
    new function() {
        /* 設定 */
        var delay    = 1000;
        var interval = 5000;
        var duration =  300;

        /* 初期設定 */
        var pos = 0;
        var tar = $('#fn-gallery-h');
        var gal = $('#fn-gallery-h-box');
        var ull = $('#fn-gallery-h-photo');
        var len = ull.children('li').length;
        var nav = $('#fn-gallery-h-nav');

        if (len > 1){

            /* nav作成 */
            for (let i = 0; i < len; i++) {
                if (i == 0){
                    $('<li class="cur"></li>').appendTo('#fn-gallery-h-nav');
                }else{
                    $('<li></li>').appendTo('#fn-gallery-h-nav');
                }
            }

            /* 表示領域幅変更時実行 */
            var width;
            var resize = function(){
                width = gal.width();
                ull.width(width * (len + 1));
                ull.children('li').width(width);
                pos = 0;
                nav.children('li').removeClass('cur');
                ull.stop(true).animate({'left': 0}, duration);
                nav.children('li').eq(pos).addClass('cur');
            }
            resize();

            /* クローン作成 */
            ull.children('li:eq(0)').clone().appendTo('#fn-gallery-h-photo');

            /* タイマー設定 */
            var intervalID, timerID;
            var start = function(){
                intervalID = setInterval(nexting, interval);
            }
            timerID = setTimeout(start, delay);

            /* 次の画像を表示 */
            var nexting = function(){
                var left;
                ull.stop(true);
                left = ++pos * -width;
                ull.animate({'left': left}, duration, function(){
                    nav.children('li').removeClass('cur');
                    if (pos >= len){
                        pos = 0;
                        ull.css('left', '0');
                    }
                    nav.children('li').eq(pos).addClass('cur');
                });
            }

            /* 次の画像を表示 */
            var next = function(){
                clearTimeout(timerID);
                clearInterval(intervalID);
                nexting();
                timerID = setTimeout(start, delay);
            }

            /* navをクリック */
            nav.children('li').click(function(){
                pos = $(this).index();
                var left;
                ull.stop(true);
                left = pos * -width;
                nav.children('li').removeClass('cur');
                ull.animate({'left': left}, duration);
                nav.children('li').eq(pos).addClass('cur');
            });

            /* イベント：表示領域変更検知 */
            var event_timer = false;
            $(window).resize(function(){
                if (event_timer !== false){
                    clearTimeout(event_timer);
                }
                event_timer = setTimeout(function(){
                    resize();
                    clearTimeout(timerID);
                    clearInterval(intervalID);
                    timerID = setTimeout(start, delay);
                }, 200);
            });

        }
    }
});
