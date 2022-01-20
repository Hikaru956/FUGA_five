$(function()
{
/* mobile navigation */
    new function() {
        var head = $('#header');
        $('#navopener').click(function(){
            if (head.hasClass('navshow')){
                head.removeClass('navshow');
            }else{
                head.addClass('navshow');
            }
        })
        $('#overlay').click(function(){
            head.removeClass('navshow');
        });
    }
/* scrolll effect */
    new function() {
        var ww = $(window).width();
        var wh = $(window).height();
        var nav = 64;
/* scroll event */
        var body = 0;
        var bods = 0;
        var head = $('#header');
        $(window).scroll(function(){
            body = $(this).scrollTop();
/* header effect */
            if(body < nav){
                head.removeClass('close');
            }else if (body < bods){
                head.removeClass('close');
            }else{
                head.addClass('close');
            }
            bods = body;
        });
    }
});
