$(function()
{
    /* グローバルナビゲーション */
    new function() {
        var body  = $('#body');
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
/*
            if (nav.hasClass('navshow'))
            {
                nav.removeClass('navshow');
                return false;
            }
*/
            nav.removeClass('navshow');
        });
/*
        $(window).scroll(function()
        {
            if ($(window).scrollTop() > 480)
            {
                gotop.fadeIn(800);
            }
            else
            {
                gotop.fadeOut(800);
            }
        });
*/
        /* ページTOPへスクロール */
/*
        gotop.click(function(){
            wind.animate({scrollTop:0}, 400);
            return false;
        });
*/
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
});
