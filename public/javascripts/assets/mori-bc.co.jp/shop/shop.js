$(function()
{
    new function() {
        var tnav  = $('#tnav');
        var body  = $('#body');
        var gotop = $('#gotop');
        /* スマホナビ表示 */
        $('#tnav_open').click(function()
        {
            if (tnav.hasClass('show'))
            {
                tnav.removeClass('show');
            }
            else
            {
                tnav.addClass('show');
            }
            return false;
        });
        body.click(function()
        {
            if (tnav.hasClass('show'))
            {
                tnav.removeClass('show');
                return false;
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
    /* グローバルナビゲーション */
    new function() {
        /* 初期設定 */
        var ll = 0;  /* LI.length */
        var lw = []; /* 各LI.width */
        var mw = 0;  /* UL.width */
        var or = '<li id="gnav_tmp"><span>MORE <i class="fa fa-chevron-circle-down"></i></span></li>'
        var ow = 0;

        $('#gnav > li').each(function(){
            ll = lw.push($(this).outerWidth());
        });
        /* 先頭非表示 */
        lw.shift();
        ll--;
        lw.forEach(function(v){
            mw += v;
        });
        $('#gnav > li:last-child').after(or);
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
            var nw = $('#gnav').width() - $('#nshop').width() - 1;
            var ww = 0;
            var i  = 0;
            if (nw <= mw){
                for (i=0; i<ll; i++){
                    ww += lw[i];
                    if (ww + ow >= nw){
                        break;
                    }
                }
                $('#gnav > li:gt('+(i-1)+')').wrapAll('<li id="gnav_drop"><ul></ul></li>');
                $('#gnav_drop').prepend('<span>MORE <i class="fa fa-chevron-circle-down"></i></span>');
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
