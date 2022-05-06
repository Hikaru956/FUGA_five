$(function(){
    new function(){
        var t = $('#homeCarousel li');
        var n = t.length;
        var i = 1;
        var f = function(){
            if (i >= n){
                t.eq(i - 1).css('opacity', '0');
                i = 1;
            } else {
                t.eq(i).css('opacity', '1');
                if (i > 1){
                    t.eq(i - 1).css('opacity', '0');
                }
                i++;
            }
        };
        if (n > 1){
            setInterval(f, 8000);
        }
    }
});
