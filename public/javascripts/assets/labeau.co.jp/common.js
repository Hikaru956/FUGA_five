$(function()
{
    new function() {
        var wh    = $(document).height();
        var main  = $('#main');
        var nav   = $('#nav');
        var top   = $('#gotop');
        /* スマホナビ表示 */
        $('#nav_btn').click(function()
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
        main.click(function()
        {
            if (nav.hasClass('navshow'))
            {
                nav.removeClass('navshow');
                return false;
            }
        });
        main.scroll(function()
        {
            if (main.scrollTop() > 1.5*wh)
            {
                top.fadeIn(800);
            }
            else
            {
                top.fadeOut(800);
            }
        });
        /* ページTOPへスクロール */
        top.click(function(){
            main.animate({scrollTop:0}, 400);
            return false;
        });
    }
    /* フットナビゲーション */
    new function() {
        /* 初期設定 */
        var ll = 0;  /* LI.length */
        var lw = []; /* 各LI.width */
        var mw = 0;  /* UL.width */
        var or = '<li id="fnav_tmp"><span>MORE <i class="fa fa-chevron-circle-down"></i></span></li>'
        var ow = 0;

        $('#fnav_main > li').each(function(){
            ll = lw.push($(this).outerWidth());
        });
        lw.forEach(function(v){
            mw += v;
        });
        $('#fnav_main > li:last-child').after(or);
        ow = $('#fnav_tmp').outerWidth() + 40;
        $('#fnav_tmp').remove();

        /* ドロップダウン削除 */
        var rem = function(){
            var dp = $('#fnav_drop');
            dp.after($('#fnav_drop li'));
            dp.remove();
        }

        /* ドロップダウン追加 */
        var app = function(){
            var nw = $('#fnav > div.container').width();
            var ww = 0;
            var i  = 0;
            if (nw < mw){
                for (i=0; i<ll; i++){
                    ww += lw[i];
                    if (ww + ow >= nw){
                        break;
                    }
                }
                $('#fnav_main > li:gt('+(i-1)+')').wrapAll('<li id="fnav_drop"><ul></ul></li>');
                $('#fnav_drop').prepend('<span>MORE <i class="fa fa-chevron-circle-down"></i></span>');
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
