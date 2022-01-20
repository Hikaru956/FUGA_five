$(function()
{
    new function() {
        var hd = $('#header');
        var hh = hd.height();
        var sn = 0;
        var so = 0;
        /* ヘッダー表示 */
        $(window).scroll(function()
        {
            sn = $(this).scrollTop();
            if (so > sn)
            {
                hd.addClass('show');
            }
            else if (so < sn && hh < sn)
            {
                hd.removeClass('show');
            }
            so = sn;
        });
        /* スマホナビ表示 */
        var nav = $('#nav');
        $('#nav-opener').click(function()
        {
            nav.addClass('show');
            return false;
        });
        $('.icon-times').click(function()
        {
            nav.removeClass('show');
            rs.removeClass('show');
            return false;
        });
        /* 予約表示 */
        var rs = $('#reserve');
        $('.reserve-opener').click(function()
        {
            rs.addClass('show');
            return false;
        });
    }
    new function() {
        var cw = $('#carousel div').width();
        var ul = $('#carousel ul');
        var li = $('li', '#carousel');
        var ln = li.size();
        var cn = 0;
        li.width(cw);
        ul.width(cw * (ln + 1));
        ul.append($('#carousel li:first').clone());
        var ev = function(){
            cn = cn - cw;
            ul.animate({left: cn+'px'}, {duration: 600, complete: function(){
                if (cn <= -cw * ln){
                    ul.css('left', 0);
                    cn = 0;
                }
            }});
        };
        setInterval(ev, 5000);
/*
        var timer = 0;
        window.onresize = function(){
            if (timer > 0){
                clearTimeout(tomer);
            }
            timer = setTimeout(function(){
                cw = $('#carousel div').width();
                ul.width(cw * (ln + 1));
                li.width(cw);
            }, 200);
        };
*/
    }
});
