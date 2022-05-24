$(function()
{
    new function() {
        var nav  = $('#gnav');
        var lay  = $('#gnav_overlay');
        /* スマホナビ表示 */
        $('#tnav_open_btn').click(function()
        {
            if (nav.hasClass('navshow'))
            {
                nav.removeClass('navshow');
                lay.removeClass('navshow');
            }
            else
            {
                lay.addClass('navshow');
                nav.addClass('navshow');
            }
            return false;
        });
        lay.click(function()
        {
            if (nav.hasClass('navshow'))
            {
                nav.removeClass('navshow');
                lay.removeClass('navshow');
                return false;
            }
        });
    }
});
