$(function() {
/* mobile navigation */
    new function() {
        var h = $('#header');
        var o = $('#overlay');
        $('#nav-opener').click(function() {
            if (o.hasClass('show')) {
                h.addClass('show');
                o.removeClass('show');
            } else {
                o.addClass('show');
            }
        })
        o.click(function() {
            h.addClass('show');
            o.removeClass('show');
            return false;
        })
    }
/* scrolll effect */
    new function() {
        var body = 0;
        var bods = 0;
        var nav = 66;
        var head = $('#header');
        var scrl = $('#scroll');
        $(window).scroll(function() {
            body = $(this).scrollTop();
/* header effect */
            if ($('#overlay').hasClass('show')) {
                head.addClass('show');
            } else if (body < nav) {
                head.addClass('show');
                scrl.addClass('show');
            } else if (body < bods) {
                head.addClass('show');
            } else {
                head.removeClass('show');
                scrl.removeClass('show');
            }
            bods = body;
        })
    }
});
