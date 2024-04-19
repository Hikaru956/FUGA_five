$(function()
{
    'use strict';
    /* carousel effect */
    new function() {

        const int = 8000;
        const tgt = $('#carouselback > li');
        const len = tgt.length;

        let i = 1;
        let f = function() {
            if (i >= len) {
                tgt.eq(i - 1).css('opacity', '0');
                i = 1;
            } else {
                tgt.eq(i).css('opacity', '1');
                if (i > 1){
                    tgt.eq(i - 1).css('opacity', '0');
                }
                i++;
            }
        };
        if (len > 1){
            setInterval(f, int);
        }
    }
});
