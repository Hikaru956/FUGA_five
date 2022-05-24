$(function()
{
    new function()
    {
        var main  = $('#main');
        var mnav  = $('#mNav');
        var gotop = $('#goTop');

/* mobile navigation opener */
        $('#mNavButton').click(function(){
            mnav.addClass('show');
            return false;
        });
        main.click(function(){
            mnav.removeClass('show');
        });
        $('#mNav li:first-child').click(function(){
            mnav.removeClass('show');
        });

/* page top button */
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
            main.animate({scrollTop:0}, 600);
            return false;
        });
    }

/* gloval navigation */
    new function() {
        /* init */
        var ll = 0;  /* LI.length */
        var lw = []; /* LI.width array */
        var mw = 0;  /* UL.Allwidth */
        var or = '<li id="gnav_tmp"><span>・・・</span></li>'
        var ow = 0;

        $('#gnav > li').each(function(){
            ll = lw.push($(this).outerWidth());
        });
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
            var nw = $('#nav').width();
            var ww = 0;
            var i  = 0;
            if (nw < mw){
                for (i=0; i<ll; i++){
                    ww += lw[i];
                    if (ww + ow >= nw){
                        break;
                    }
                }
                $('#gnav > li:gt('+(i-1)+')').wrapAll('<li id="gnav_drop"><ul></ul></li>');
                $('#gnav_drop').prepend('<span>・・・</span>');
            }
        }

        rem();
        app();

        var scr = $('#nav').width();
        var event_timer = false;
        $(window).resize(function(){
            if (event_timer !== false){
                clearTimeout(event_timer);
            }
            event_timer = setTimeout(function(){
                if (scr != $('#nav').width()){
                    rem();
                    app();
                    scr = $('#nav').width();
                }
            }, 200);
        });
    }
});
