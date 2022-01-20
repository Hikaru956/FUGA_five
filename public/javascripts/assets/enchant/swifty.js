$(function()
{
    var body  = $('#body');
    var gotop = $('#gotop');
    $('#smart_nav_opener_btn').click(function()
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
        body.removeClass('navshow');
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
    gotop.click(function(){
        body.animate({scrollTop:0}, 400);
    });

    var obj = $('.bxslider').bxSlider({
        auto: true,
        speed: 1500,
        pause: 5000,
        pager: true,
        autoHover: true,
        controls: false,
        onSlideAfter: function () { obj.startAuto(); }
    });
});
