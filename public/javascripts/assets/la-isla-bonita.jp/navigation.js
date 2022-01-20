$(function()
{
    /* グローバルナビゲーション */
    new function() {
        var w = $(window).width();
        var h = $(window).height();

        if (w >= 600 && h >= 600){

            /* 初期設定 */
            var ll = 0;  /* LI.length */
            var lw = []; /* 各LI.width */
            var mw = 0;  /* UL.width */
            var or = '<li id="gnav_tmp"><span>MORE <i class="fa fa-chevron-circle-down"></i></span></li>'
            var ow = 0;

            $('#gnav_main > li').each(function(){
                ll = lw.push($(this).outerWidth());
            });
            lw.forEach(function(v){
                mw += v;
            });
            $('#gnav_main > li:last-child').after(or);
            ow = $('#gnav_tmp').outerWidth() + 40;
            $('#gnav_tmp').remove();

            /* ドロップダウン削除 */
            var rem = function(){
                var dp = $('#gnav_drop');
                dp.after($('#gnav_drop li'));
                dp.remove();
            }

            /* ドロップダウン追加 */
            var app = function(){
                var nw = $('#gnav > div.container').width();
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
    }
});
