$(function()
{
    /* グローバルナビゲーション */
    new function() {
        /* 初期設定 */
        var wrap = $('#gnav_wrapper');
        var ul   = $('#gnav_wrapper > ul');
        var next = $('#gnav_next');
        var prev = $('#gnav_prev');

        /* ナビがオーバーフローする場合の設定 */
        var navini = function(){
            prev.css({'display': 'block'});
            next.css({'display': 'block'});
            wrap.css({
                'white-space': 'nowrap',
                'position': 'absolute',
                'top': '0',
                'left': '2em',
                'right': '2em'
            });
            ul.css({
                'position': 'absolute',
                'top': '0',
                'left': '0',
            });
        }
        var ht2 = 84;
        var gwh = wrap.height();
        if (gwh >= ht2){
            navini();
        }

        var gww = wrap.width();
        var ulw = ul.width();
        var max = -1 * (ulw - gww);

        var nexting = function(){
            var gwl = ul.position()
            if (gwl.left > max){
                if (gwl.left - .9*gww > max){
                    ul.css('left', '-='+.9*gww);
                } else {
                    ul.css('left',  max);
                }
            }
        }
        var preving = function(){
            var gwl = ul.position()
            if (gwl.left < 0){
                if (gwl.left + .9*gww < 0){
                    ul.css('left', '+='+.9*gww);
                } else {
                    ul.css('left', 0);
                }
            }
        }

        prev.click(function(){
            preving();
            return false;
        });
        prev.on('tap', function(){
            preving();
            return false;
        });
        wrap.on('swipeleft', function(){
            preving();
            return false;
        });
        next.click(function(){
            nexting();
            return false;
        });
        next.on('tap', function(){
            nexting();
            return false;
        });
        wrap.on('swiperight', function(){
            nexting();
            return false;
        });

        var event_timer = false;
        $(window).resize(function(){
            if (event_timer !== false){
                clearTimeout(event_timer);
            }
            event_timer = setTimeout(function(){
                gwh = wrap.height();
                if (gwh >= ht2){
                    navini();
                }
                gww = wrap.width();
                ulw = ul.width();
                max = -1 * (ulw - gww);
            }, 200);
        });
    }
});
