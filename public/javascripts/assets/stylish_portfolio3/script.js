$(function() {
/* mobile navigation */
    new function() {
        var w = $(window);
        var r = $('html');
        var h = $('#header');
        var g = $('#gnav');
        $('#navopener').click(function() {
            r.addClass('noscroll');
            g.addClass('show');
        });
        $('#navcloser').click(function() {
            r.removeClass('noscroll');
            h.addClass('show');
            g.removeClass('show');
            return false;
        });
        var lh = 0;
        $.each($('#gnav ul.nav > li'), function(i, e){
            lh += $(e).outerHeight();
        });
        w.resize(rs);
        function rs(){
            var wh = w.height();
            if ((wh - 96) < lh){
                $('#scguide').addClass('show');
            }else{
                $('#scguide').removeClass('show');
            }
            g.height(wh);
        };
        rs();
    }
/* scrolll effect */
    new function() {
        var ns = 0;
        var os = 0;
        var nv = 320;
        var hd = $('#header');
        var gt = $('#gotop');
        $(window).scroll(function() {
            ns = $(this).scrollTop();
            if (ns > os) {
/*
                hd.removeClass('show');
*/
            } else {
                hd.addClass('show');
            }
            if (ns > nv) {
                gt.addClass('show');
            } else {
                gt.removeClass('show');
            }
            os = ns;
        })
    }
/* carousel effect */
    new function() {
        var t = $('#carouselback > li');
        var n = t.length;
        var i = 1;
        var f = function(){
            if (i >= n){
                t.eq(i - 1).css('opacity', '0');
                i = 1;
            } else {
                t.eq(i).css('opacity', '1');
                if (i > 1){
                    t.eq(i - 1).css('opacity', '0');
                }
                i++;
            }
        };
        if (n > 1){
            setInterval(f, 8000);
        }
    }
});
