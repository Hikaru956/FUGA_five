$(function()
{
    'use strict';
    /* navigation */
    new function() {

        const gnav = $('#gnav');
        const back = $('#gnavback');
        const cont = $('#gnavcontent');
        const head = $('#carousel #header');
        const abot = $('#article.about');


        const ao = function(){
            abot.addClass('show');
        };
        setTimeout(ao, 2000);


        const sw = function(){
            head.addClass('show');
        };
        setTimeout(sw, 2000);


        const op = function(){
            cont.css('opacity', 1);
        };
        const open = function(){
            back.css('display', 'block').css('opacity', 1);
            gnav.addClass('show');
            setTimeout(op, 600);
        };
        const cl = function(){
            back.css('display', 'none');
            cont.css('opacity', 0);
        };
        const close = function(){
            back.css('opacity', 0);
            gnav.removeClass('show');
            setTimeout(cl, 600);
        };


        $('#navopner').on('click',function() {
            open();
        });
        $('#navcloser').on('click',function() {
            close();
        });
        back.on('click',function() {
            close();
        });
    }
});
