$(function()
{
  new function()
  {
    var mnav  = $('#mNav');
    var gotop = $('#goTop');

/* mobile navigation opener */
    $('#mNavButton').click(function(){
        mnav.addClass('show');
        return false;
    });
    $('#main').click(function(){
        mnav.removeClass('show');
    });
    $('.fa-times').click(function(){
        mnav.removeClass('show');
    });
/* page top button */
    $(window).scroll(function()
    {
        if ($(window).scrollTop() > 480)
        {
            gotop.addClass('show');
        }
        else
        {
            gotop.removeClass('show');
        }
    });
    gotop.click(function(){
        $("html,body").animate({scrollTop:0}, 600);
        return false;
    });
  }
});
