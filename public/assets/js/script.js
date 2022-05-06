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
        })
    }
/* scrolll effect */
    new function() {
        var ww = $(window).width();
        var wh = $(window).height();
        var nav = 64;
/* cocept */
        var cop = $('#concept > p');
        var con = [];
        cop.each(function(index){
            con[index] = $(this).offset().top;
            if (wh * 0.95 < con[index]){
                cop.eq(index).css('opacity',0);
            }
        });
/* contents */
        var col = $('.contentslist > li');
        var cot = [];
        col.each(function(index){
            cot[index] = $(this).offset().top;
            if (wh * 0.95 < cot[index]){
                col.eq(index).css('opacity',0);
            }
        });
/* resize init */
        var event_timer = false;
        $(window).resize(function(){
            if (event_timer !== false){
                clearTimeout(event_timer);
            }
            event_timer = setTimeout(function(){
                ww = $(window).width();
                wh = $(window).height();
                cop.each(function(index){
                    con[index] = $(this).offset().top;
                });
                col.each(function(index){
                    cot[index] = $(this).offset().top;
                });
            }, 200);
        })
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
/* cocept effect */
            cop.each(function(index){
                if (wh > (con[index] - body) / 0.85){
                    cop.eq(index).css('opacity',1);
                }else if (wh > (con[index] - body) / 0.95){
                    cop.eq(index).css('opacity',0);
                }
            });
/* contents effect */
            col.each(function(index){
                if (wh > (cot[index] - body) / 0.85){
                    col.eq(index).css('opacity',1);
                }else if (wh > (cot[index] - body) / 0.95){
                    col.eq(index).css('opacity',0);
                }
            });
        })
    }
});
