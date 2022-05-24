$(function()
{
    new function() {
        var delay    = 1000;
        var interval = 5000;
        var duration =  300;

        var position = 0;
        var gal      = $('#gallery');
        var ul       = $('#gallery > ul');
        var length   = ul.children('li').length;
        ul.children('li').first().clone().appendTo('#gallery > ul');

        var width;
        var resize = function(){
            width = gal.width();
            ul.width(width * (length+1));
            ul.children('li').width(width);
            position = 0;
            ul.stop(true).animate({'left': 0}, duration);
            gal.height(ul.height());
        }
        window.onload = resize();

        var intervalID, timerID;
        var start = function(){
            intervalID = setInterval(nexting, interval);
        }
        timerID = setTimeout(start, delay);

        var nexting = function(){
            var left = ++position * -width;
            ul.stop(true).animate({'left': left}, duration, function(){
                if (position >= length){
                    ul.css({'left': '0'});
                    position = 0;
                }
            });
        }
        var next = function(){
            clearTimeout(timerID);
            clearInterval(intervalID);
            nexting();
            timerID = setTimeout(start, delay);
        }
        var prev = function(){
            var left;
            ul.stop(true);
            clearTimeout(timerID);
            clearInterval(intervalID);
            if (position <= 0){
                position = length;
                left = position * -width;
                ul.css({'left': left});
            }
            left = --position * -width;
            ul.animate({'left': left}, duration);
            timerID = setTimeout(start, delay);
        }

        $('#gallery_next').click(function(){
            next();
            return false;
        });
        $('#gallery_next').on('tap', function(){
            next();
            return false;
        });
        $('#gallery_prev').click(function(){
            prev();
            return false;
        });
        $('#gallery_prev').on('tap', function(){
            prev();
            return false;
        });
        gal.on('swipeleft', function(){
            next();
            return false;
        });
        gal.on('swiperight', function(){
            prev();
            return false;
        });

        var event_timer = false;
        $(window).resize(function(){
            if (event_timer !== false){
                clearTimeout(event_timer);
            }
            event_timer = setTimeout(function(){
                resize();
                clearTimeout(timerID);
                clearInterval(intervalID);
                timerID = setTimeout(start, delay);
            }, 200);
        });
    }
});
