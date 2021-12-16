$(function()
{
    new function()
    {
        var main  = $('#main');
        var tnav  = $('#tnav');
        var gotop = $('#gotop');

        $('#tnav_open_btn').click(function(){
            tnav.addClass('show');
            return false;
        });
        main.click(function(){
            tnav.removeClass('show');
        });
        $('#tnav li:first-child').click(function(){
            tnav.removeClass('show');
        });

        main.scroll(function()
        {
            if (main.scrollTop() > 480)
            {
                gotop.addClass('show');
            }
            else
            {
                gotop.removeClass('show');
            }
        });
        gotop.click(function(){
            main.animate({scrollTop:0}, 400);
            return false;
        });
    }
    /* グローバルナビゲーション */
    new function() {
        /* 初期設定 */
        var ll = 0;  /* LI.length */
        var lw = []; /* 各LI.width */
        var mw = 0;  /* UL.width */
        var or = '<li id="gnav_tmp"><span>・・・</span></li>'
        var ow = 0;

        $('#gnav_main > li').each(function(){
            ll = lw.push($(this).outerWidth());
        });
        lw.forEach(function(v){
            mw += v;
        });
        $('#gnav_main > li:last-child').after(or);
        ow = $('#gnav_tmp').outerWidth();
        $('#gnav_tmp').remove();

        /* ドロップダウン削除 */
        var rem = function(){
            var dp = $('#gnav_drop');
            dp.after($('#gnav_drop li'));
            dp.remove();
        }

        /* ドロップダウン追加 */
        var app = function(){
            var nw = $('#gnav').width();
            var ww = 0;
            var i  = 0;
            if (nw < mw){
                for (i=0; i<ll; i++){
                    ww += lw[i];
                    if (ww + ow >= nw){
                        break;
                    }
                }
                $('#gnav_main > li:gt('+(i-1)+')').wrapAll('<li id="gnav_drop"><ul></ul></li>');
                $('#gnav_drop').prepend('<span>・・・</span>');
            }
        }

        rem();
        app();

        var scr = $('#header > div').width();
        var event_timer = false;
        $(window).resize(function(){
            if (event_timer !== false){
                clearTimeout(event_timer);
            }
            event_timer = setTimeout(function(){
                if (scr != $('#header > div').width()){
                    rem();
                    app();
                }
            }, 200);
        });
    }
});
