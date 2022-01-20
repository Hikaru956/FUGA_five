$(function()
{
/* mobile navigation & reserve */
    new function() {
        var wd = $(window);
        var ht = $('html');
        var hd = $('#header');
        var nv = $('#nav');
        var rc = $('#reserve-choice');
        var rb = $('#reserve-button');
        $('#nav-opener').click(function(){
            ht.addClass('noscroll');
            nv.addClass('show');
        });
        $('#nav-closer').click(function(){
            ht.removeClass('noscroll');
            nv.removeClass('show');
            hd.addClass('show');
            return false;
        });
        $('#reserve-button').click(function(){
            ht.addClass('noscroll');
            rc.addClass('show');
        });
        $('#reserve-closer').click(function(){
            ht.removeClass('noscroll');
            rc.removeClass('show');
            hd.addClass('show');
            return false;
        });
    };
/* header effect */
    new function() {
        var hd = $('#header');
        var hh = 145;
        var ws = 0;
        var wo = 0;
        $(window).scroll(function(){
            ws = $(this).scrollTop();
            if(ws < hh){
                hd.addClass('show');
            }else if (ws < wo){
                hd.addClass('show');
            }else{
                hd.removeClass('show');
            }
            wo = ws;
        });
    };
});
