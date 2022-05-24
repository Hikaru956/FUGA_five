$(function()
{
    /* スタイルギャラリー */
    new function() {
        /* 設定 */
        var delay    = 3000;
        var interval = 8000;
        var duration =  300;

        /* 初期設定 */
        var position = 0;
        var gal      = $('#gallery');
        var ul       = $('#gallery > ul');
        var length   = ul.children('li').length;

        /* 表示領域幅変更時実行 */
        var width;
        var resize = function(){
            width = gal.width();
            ul.width(width * (length));
            ul.children('li').width(width);
            position = 0;
            ul.stop(true).animate({'left': 0}, duration);
        }
        resize();

        /* タイマー設定 */
        var intervalID, timerID;
        var start = function(){
            intervalID = setInterval(nexting, interval);
        }
        timerID = setTimeout(start, delay);

        /* 次の画像を表示 */
        var nexting = function(){
            var left;
            ul.stop(true);
            if (position+1 < length){
                left = ++position * -width;
                ul.animate({'left': left}, duration);
            }
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
            if (position > 0){
                left = --position * -width;
                ul.animate({'left': left}, duration);
            }
            timerID = setTimeout(start, delay);
        }

        /* イベント：次へボタンクリック */
        $('#gallery_next').click(function(){
            next();
            return false;
        });
        /* イベント：次へボタンタップ */
        $('#gallery_next').on('tap', function(){
            next();
            return false;
        });
        /* イベント：前へボタンクリック */
        $('#gallery_prev').click(function(){
            prev();
            return false;
        });
        /* イベント：前へボタンタップ */
        $('#gallery_prev').on('tap', function(){
            prev();
            return false;
        });
        /* イベント：左スワイプ */
        gal.on('swipeleft', function(){
            next();
            return false;
        });
        /* イベント：右スワイプ */
        gal.on('swiperight', function(){
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
