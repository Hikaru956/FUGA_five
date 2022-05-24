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
});
