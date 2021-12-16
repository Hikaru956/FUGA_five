$(function()
{
    /* カルーセル */
    new function() {
        /* 設定 */
        var delay    = 1000;
        var interval = 5000;
        var duration =  600;
        var ccolor   = '#64B5F6';
        var ocolor   = '#9e9e9e';
        /* 画像の縦横比と位置調整はCSSで設定 */

        /* 初期設定 */
        var position = 0;
        var car      = $('#carouselBox');
        var ul       = $('#carouselUl');
        var pos      = $('#carousel_pos');
        var length   = ul.children('li').length;
        ul.children('li').first().clone().appendTo('#carouselUl');

        /* 表示領域幅変更時実行 */
        var width;
        var resize = function(){
            width = car.width();
            ul.width(width * (length+1));
            ul.children('li').width(width);
            ul.stop(true).animate({'left': position * -width}, duration);
            pos.children('span').css('backgroundColor',ocolor);
            pos.children('span:eq('+position+')').css('backgroundColor',ccolor);
        };

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
            pos.children('span:eq('+position+')').css('backgroundColor',ocolor);
            var left = ++position * -width;
            ul.stop(true).animate({'left': left}, duration, function(){
                if (position >= length){
                    ul.css({'left': '0'});
                    position = 0;
                }
                pos.children('span:eq('+position+')').css('backgroundColor',ccolor);
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
            pos.children('span:eq('+position+')').css('backgroundColor',ocolor);
            if (position <= 0){
                position = length;
                left = position * -width;
                ul.css({'left': left});
            }
            left = --position * -width;
            ul.animate({'left': left}, duration);
            pos.children('span:eq('+position+')').css('backgroundColor',ccolor);
            timerID = setTimeout(start, delay);
        }
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
        /* イベント：pos click */
        pos.children('span').on('click', function(){
            ul.stop(true);
            clearTimeout(timerID);
            clearInterval(intervalID);
            pos.children('span:eq('+position+')').css('backgroundColor',ocolor);
            position = pos.children('span').index(this);
            left = position * -width;
            ul.animate({'left': left}, duration);
            pos.children('span:eq('+position+')').css('backgroundColor',ccolor);
            timerID = setTimeout(start, delay);
        });
        /* イベント：表示領域変更検知 */
        var event_timer = false;
        $(window).resize(function(){
            if (event_timer !== false){
                clearTimeout(event_timer);
            }
            event_timer = setTimeout(function(){
                if (width != car.width()){
                    resize();
                    clearTimeout(timerID);
                    clearInterval(intervalID);
                    timerID = setTimeout(start, delay);
                }
            }, 200);
        });
    }
});
