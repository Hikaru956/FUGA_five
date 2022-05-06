$(function(){
    new function(){
        'use strict';
        const delay    = 5000;
        const interval = 5000;
        const duration =  600;
        const carousel = $('#carousel > div.img');
        const ul = carousel.children('ul');
        const li = ul.children('li');
        const length = ul.children('li').length;
        const nav = $('#carousel > ul.nav');
        let   position = 0;

        let width;
        let resize = function(){
            width = carousel.width();
            ul.width(width * (length + 1));
            ul.children('li').width(width);
            position = 0;
            ul.animate({'left': 0}, 0);
            if (length < 6 && width * 0.6 / length < 75){
                nav.children('li').css('width', width * 0.6 / length);
            } else if (length > 5 && width * 0.8 / length < 75) {
                nav.children('li').css('width', width * 0.8 / length);
            } else {
                nav.children('li').css('width', 75);
            }
            nav.children('li').removeClass('current');
            nav.children('li').eq(position).addClass('current');
        };

        li.eq(0).clone().appendTo(ul);
        for (let i=0; i<length; i++){
            $('<li></li>').appendTo(nav);
        }
        nav.children('li').eq(0).addClass('current');
        resize();

        let intervalID, timerID;
        let start = function(){
            intervalID = setInterval(nexting, interval);
        };
        timerID = setTimeout(start, 0);

        let nexting = function(){
            let left;
            ul.stop(true);
            if (position < length){
                left = ++position * -width;
                ul.animate({'left': left}, duration);
            }
            if (position >= length){
                position = 0;
                ul.animate({'left': 0}, 0);
            }
            nav.children('li').removeClass('current');
            nav.children('li').eq(position).addClass('current');
        };

        let event_timer = false;
        $(window).resize(function(){
            if (event_timer !== false){
                clearTimeout(event_timer);
            }
            event_timer = setTimeout(function(){
                resize();
                clearTimeout(timerID);
                clearInterval(intervalID);
                timerID = setTimeout(start, 0);
            }, 200);
        });

        nav.children('li').on('click', function(){
            position = $(this).index();
            ul.stop(true);
            ul.animate({'left': position * -width}, duration);
            nav.children('li').removeClass('current');
            nav.children('li').eq(position).addClass('current');
            clearTimeout(timerID);
            clearInterval(intervalID);
            timerID = setTimeout(start, delay);
        });
    }
});
