/* carousel */
$(function()
{
    new function()
    {
/* mNav opener */
        var mNav  = $('#mNav');
        $('#mNavOpener').click(function(){
            mNav.toggleClass('show');
            return false;
        });
        $('#body').click(function(){
            mNav.removeClass('show');
        });
/* goTop page */
        var goTop = $('#goTop');
        goTop.click(function(){
            $('html,body').animate({scrollTop:0}, 400);
            return false;
        });
/* header open/close */
        const hed = document.getElementById('header'),
              got = document.getElementById('goTop'),
              hei = 150,
              heg = 480;
        let   off = 0,
              pos = 0;
        window.addEventListener('scroll',function(e){
            pos = window.scrollY;
            window.requestAnimationFrame(function(){
                if (pos > heg){
                    got.classList.add('show');
                }else{
                    got.classList.remove('show');
                }
                if (pos > hei){
                    if (pos > off){
                        hed.classList.remove('show');
                    }else{
                        hed.classList.add('show');
                    }
                    off = pos;
                }
            });
        });
    }
});
