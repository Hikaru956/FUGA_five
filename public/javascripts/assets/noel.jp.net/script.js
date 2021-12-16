$(function()
{
    new function() {
        var mnav = $('#mNav');
        /* スマホナビ表示 */
        $('#mNavOpener').click(function()
        {
            if (mnav.hasClass('show'))
            {
                mnav.removeClass('show');
            }
            else
            {
                mnav.addClass('show');
            }
            return false;
        });
        mnav.click(function(e)
        {
            e.stopPropagation();
        });
        $('body').click(function()
        {
            if (mnav.hasClass('show'))
            {
                mnav.removeClass('show');
                return false;
            }
        });
    }
    /* カルーセル */
    new function() {
        /* 設定 */
        var delay    = 1000;
        var interval = 5000;
        var duration =  600;
        /* 画像の縦横比と位置調整はCSSで設定 */

        /* 初期設定 */
        var position = 0;
        var car      = $('#carousel-list');
        var ul       = $('#carousel-ul');
        var length   = ul.children('li').length;
        if (length > 1){
            ul.children('li').first().clone().appendTo('#carousel-ul');
    
            var nav = $('#carousel-nav');
            var li  = "";
            for (var i = -1; ++i < length;){
                li += "<li>□</li>";
            }
            nav.append(li);
            nav.children('li').eq(0).text('■');
    
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
                nav.children('li').text('□');
                var left = ++position * -width;
                ul.stop(true).animate({'left': left}, duration, function(){
                    if (position >= length){
                        ul.css({'left': '0'});
                        position = 0;
                    }
                    nav.children('li').eq(position).text('■');
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
                nav.children('li').text('□');
                if (position <= 0){
                    position = length;
                    left = position * -width;
                    ul.css({'left': left});
                }
                left = --position * -width;
                ul.animate({'left': left}, duration);
                nav.children('li').eq(position).text('■');
                timerID = setTimeout(start, delay);
            }
    
            /* イベント：次へボタンクリック */
            $('#carousel_next').click(function(){
                next();
                return false;
            });
            /* イベント：次へボタンタップ */
            $('#carousel_next').on('tap', function(){
                next();
                return false;
            });
            /* イベント：前へボタンクリック */
            $('#carousel_prev').click(function(){
                prev();
                return false;
            });
            /* イベント：前へボタンタップ */
            $('#carousel_prev').on('tap', function(){
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
    }
});
