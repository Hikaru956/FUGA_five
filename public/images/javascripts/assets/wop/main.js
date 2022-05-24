$(function()
{
    new function() {
        var mnav = $('#mnav');
        var back = $('#mnav_back');
        /* スマホナビ表示 */
        $('#nav_opener').click(function()
        {
            back.addClass('visible show');
            setTimeout(function(){
                mnav.addClass('show');
            }, 100);
            return false;
        });
        back.click(function()
        {
            mnav.removeClass('show');
            setTimeout(function(){
                back.removeClass('show');
            }, 100);
            setTimeout(function(){
                back.removeClass('visible');
            }, 300);
            return false;
        });
        /* ページTOPへスクロール */
        $('#top').click(function(){
            $('#body').animate({scrollTop:0}, 400);
            return false;
        });
    }
});
