$(function()
{
    var body  = $('#body');
    var gotop = $('#gotop');
    $('.nav_opener_btn').click(function(){
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
    body.click(function(){
        body.removeClass('navshow');
    });
    body.scroll(function(){
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
});
