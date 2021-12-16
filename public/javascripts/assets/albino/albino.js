$(function()
{
    new function() {
        var body  = $('#body');
        var gotop = $('#gotop');
        /* スマホナビ表示 */
        $('#tnav_open_btn').click(function()
        {
            if (body.hasClass('navshow'))
            {
                body.removeClass('navshow');
            }
            else
            {
                body.addClass('navshow');
            }
            return false;
        });
        body.click(function()
        {
            if (body.hasClass('navshow'))
            {
                body.removeClass('navshow');
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
    new function() {
        var clean = function(){
            $('#header_add').css({
                'position': 'static'
            });
        }
        var resize = function(){
            var ww = $(window).width();
            clean();
            if (ww >= 600){
                var ih = $('#header_img').height();
                var sh = $('#summary').outerHeight();
                var ah = $('#header_add').outerHeight();

                if (ih > sh + ah){
                    $('#header_add').css({
                        'position': 'absolute'
                    });
                }
            }
        }
        resize();
        /* イベント：表示領域変更検知 */
        var event_timer = false;
        $(window).resize(function(){
            if (event_timer !== false){
                clearTimeout(event_timer);
            }
            event_timer = setTimeout(function(){
                resize();
            }, 200);
        });
    }
});
