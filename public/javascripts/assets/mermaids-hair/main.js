$(function()
{
    /* グローバルナビゲーション */
    new function() {
        var body  = $('body');
        var nav   = $('#nav');
        var gotop = $('#gotop');
        /* スマホナビ表示 */
        $('#nav_open_btn').click(function()
        {
            if (nav.hasClass('navshow'))
            {
                nav.removeClass('navshow');
            }
            else
            {
                nav.addClass('navshow');
            }
            return false;
        });
        body.click(function()
        {
            if (nav.hasClass('navshow'))
            {
                nav.removeClass('navshow');
/*                return false; */
            }
        });
        body.scroll(function()
        {
            if (body.scrollTop() > 480)
            {
                gotop.fadeIn(800);
            }
            else
            {
                gotop.fadeOut(800);
            }
        });
        /* ページTOPへスクロール */
        gotop.click(function(){
            body.animate({scrollTop:0}, 400);
            return false;
        });
    }
    new function() {
        /* 初期設定 */
        var ll = 0;  /* LI.length */
        var lw = []; /* 各LI.width */
        var mw = 0;  /* UL.width */
        var or = '<li id="nav_tmp"><span>MORE <i class="fa fa-chevron-circle-down"></i></span></li>'
        var ow = 0;

        $('#nav_main > li').each(function(){
            ll = lw.push($(this).outerWidth());
        });
        lw.forEach(function(v){
            mw += v;
        });
        $('#nav_main > li:last-child').after(or);
        ow = $('#nav_tmp').outerWidth() + 40;
        $('#nav_tmp').remove();

        /* ドロップダウン削除 */
        var rem = function(){
            var dp = $('#nav_drop');
            dp.after($('#nav_drop li'));
            dp.remove();
        }

        /* ドロップダウン追加 */
        var app = function(){
            var nw = $('#nav > div.container').width();
            var ww = 0;
            var i  = 0;
            if (nw < mw){
                for (i=0; i<ll; i++){
                    ww += lw[i];
                    if (ww + ow >= nw){
                        break;
                    }
                }
                $('#nav_main > li:gt('+(i-1)+')').wrapAll('<li id="nav_drop"><ul></ul></li>');
                $('#nav_drop').prepend('<span>MORE <i class="fa fa-chevron-circle-down"></i></span>');
            }
        }

        rem();
        app();

        var event_timer = false;
        $(window).resize(function(){
            if (event_timer !== false){
                clearTimeout(event_timer);
            }
            event_timer = setTimeout(function(){
                rem();
                app();
            }, 200);
        });
    }
    /* フッターカルーセル１ */
    new function() {
        /* 設定 */
        var delay    = 1000;
        var interval = 5000;
        var duration = 1000;
        /* 画像の縦横比と位置調整はCSSで設定 */

        /* 初期設定 */
        var position = 0;
        var car      = $('#carousel1 > div');
        var ul       = $('#carousel1_ul');
        var length   = ul.children('li').length;
        ul.children('li').first().clone().appendTo('#carousel1_ul');

        /* 表示領域幅変更時実行 */
        var width;
        var resize = function(){
            width = car.width();
            ul.width(width * (length+1));
            ul.children('li').width(width);
            position = 0;
            ul.stop(true).animate({'left': 0}, duration);
        }

        $(window).load(function(){
            resize();
        });

        /* タイマー設定 */
        var intervalID, timerID;
        var start = function(){
            intervalID = setInterval(nexting, interval);
        }
        timerID = setTimeout(start, delay);

        /* 次の画像を表示 */
        var nexting = function(){
            var left = ++position * -width;
            ul.stop(true).animate({'left': left}, duration, function(){
                if (position >= length){
                    ul.css({'left': '0'});
                    position = 0;
                }
            });
        }
        /* 次の画像を表示 */
        var next = function(){
            clearTimeout(timerID);
            clearInterval(intervalID);
            nexting();
            timerID = setTimeout(start, delay);
        }
        /* 前の画像を表示 */
        var prev = function(){
            var left;
            ul.stop(true);
            clearTimeout(timerID);
            clearInterval(intervalID);
            if (position <= 0){
                position = length;
                left = position * -width;
                ul.css({'left': left});
            }
            left = --position * -width;
            ul.animate({'left': left}, duration);
            timerID = setTimeout(start, delay);
        }

        /* イベント：次へボタンクリック */
        $('#carousel1_next').click(function(){
            next();
            return false;
        });
        /* イベント：次へボタンタップ */
        $('#carousel1_next').on('tap', function(){
            next();
            return false;
        });
        /* イベント：前へボタンクリック */
        $('#carousel1_prev').click(function(){
            prev();
            return false;
        });
        /* イベント：前へボタンタップ */
        $('#carousel1_prev').on('tap', function(){
            prev();
            return false;
        });
        /* イベント：左スワイプ */
        car.on('swipeleft', function(){
            next();
            return false;
        });
        /* イベント：右スワイプ */
        car.on('swiperight', function(){
            prev();
            return false;
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
    /* フッターカルーセル１ */
    new function() {
        /* 設定 */
        var delay    = 1000;
        var interval = 5000;
        var duration = 1000;
        /* 画像の縦横比と位置調整はCSSで設定 */

        /* 初期設定 */
        var position = 0;
        var car      = $('#carousel2 > div');
        var ul       = $('#carousel2_ul');
        var length   = ul.children('li').length;
        ul.children('li').first().clone().appendTo('#carousel2_ul');

        /* 表示領域幅変更時実行 */
        var width;
        var resize = function(){
            width = car.width();
            ul.width(width * (length+1));
            ul.children('li').width(width);
            position = 0;
            ul.stop(true).animate({'left': 0}, duration);
        }

        $(window).load(function(){
            resize();
        });

        /* タイマー設定 */
        var intervalID, timerID;
        var start = function(){
            intervalID = setInterval(nexting, interval);
        }
        timerID = setTimeout(start, delay);

        /* 次の画像を表示 */
        var nexting = function(){
            var left = ++position * -width;
            ul.stop(true).animate({'left': left}, duration, function(){
                if (position >= length){
                    ul.css({'left': '0'});
                    position = 0;
                }
            });
        }
        /* 次の画像を表示 */
        var next = function(){
            clearTimeout(timerID);
            clearInterval(intervalID);
            nexting();
            timerID = setTimeout(start, delay);
        }
        /* 前の画像を表示 */
        var prev = function(){
            var left;
            ul.stop(true);
            clearTimeout(timerID);
            clearInterval(intervalID);
            if (position <= 0){
                position = length;
                left = position * -width;
                ul.css({'left': left});
            }
            left = --position * -width;
            ul.animate({'left': left}, duration);
            timerID = setTimeout(start, delay);
        }

        /* イベント：次へボタンクリック */
        $('#carousel2_next').click(function(){
            next();
            return false;
        });
        /* イベント：次へボタンタップ */
        $('#carousel2_next').on('tap', function(){
            next();
            return false;
        });
        /* イベント：前へボタンクリック */
        $('#carousel2_prev').click(function(){
            prev();
            return false;
        });
        /* イベント：前へボタンタップ */
        $('#carousel2_prev').on('tap', function(){
            prev();
            return false;
        });
        /* イベント：左スワイプ */
        car.on('swipeleft', function(){
            next();
            return false;
        });
        /* イベント：右スワイプ */
        car.on('swiperight', function(){
            prev();
            return false;
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
});
