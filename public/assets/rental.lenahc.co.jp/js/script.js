$(function()
{
    new function() {
        $('#cage-nav-opener').click(function(){
            if ($('#cage-nav').hasClass('show')){
                $('#cage-nav').removeClass('show');
            }else{
                $('#cage-nav').addClass('show');
                $('#grad-nav').removeClass('show');
            }
        });
        $('#grad-nav-opener').click(function(){
            if ($('#grad-nav').hasClass('show')){
                $('#grad-nav').removeClass('show');
            }else{
                $('#cage-nav').removeClass('show');
                $('#grad-nav').addClass('show');
            }
        });
        $('#mobile-nav-opener').click(function(){
            if ($('#mobile-nav').hasClass('show')){
                $('#mobile-nav').removeClass('show');
                $('#gotop').addClass('show');
            }else{
                $('#mobile-nav').addClass('show');
                $('#gotop').removeClass('show');
            }
        });
        $('body').scroll(function(){
            $('#cage-nav').removeClass('show');
            $('#grad-nav').removeClass('show');
        });
        $('#mobile-nav a').click(function(){
            $('#mobile-nav').removeClass('show');
        });
    }
    new function() {
        const int = 5000;
        const crs = $('#crousel');
        const cru = $('#crousel > ul');
        let   pos = 0;
        let   wid = crs.width();
        let   len = cru.children('li').length;
        if (len > 1){
            cru.width(wid * (len + 1));
            cru.children('li').first().clone().appendTo('#crousel > ul');
            setInterval(function(){
                cru.stop(true).animate({'left': ++pos * -wid}, 600, function(){
                    if (pos >= len){
                        pos = 0;
                        cru.css({'left': 0});
                    }
                });
            }, int);
            let timer = false;
            $(window).resize(function(){
                if (timer !== false){
                    clearTimeout(timer);
                }
                timer = setTimeout(function(){
                    wid = crs.width();
                    cru.width(wid * (len + 1));
                }, 200);
            });
        }
    }
    new function() {
        const int = 5000;
        const crs = $('#crouselm');
        const cru = $('#crouselm > ul');
        let   pos = 0;
        let   wid = crs.width();
        let   len = cru.children('li').length;
        if (len > 1){
            cru.width(wid * (len + 1));
            cru.children('li').first().clone().appendTo('#crouselm > ul');
            setInterval(function(){
                cru.stop(true).animate({'left': ++pos * -wid}, 600, function(){
                    if (pos >= len){
                        pos = 0;
                        cru.css({'left': 0});
                    }
                });
            }, int);
            let timer = false;
            $(window).resize(function(){
                if (timer !== false){
                    clearTimeout(timer);
                }
                timer = setTimeout(function(){
                    wid = crs.width();
                    cru.width(wid * (len + 1));
                }, 200);
            });
        }
    }
    new function() {
        $('#faq dd').slideUp(0);
        $('#faq dt').click(function(){
            $(this).next('dd').slideToggle();
        });
    }
});
