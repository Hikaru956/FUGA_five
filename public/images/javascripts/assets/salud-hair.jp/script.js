$(function()
{
    new function() {
        var mNav = $('#mNav');
        /* スマホナビ表示 */
        $('#mnav_open_btn').click(function()
        {
            if (mNav.hasClass('show'))
            {
                mNav.removeClass('show');
            }
            else
            {
                mNav.addClass('show');
            }
        });
        $('#body').click(function()
        {
            if (mNav.hasClass('show'))
            {
                mNav.removeClass('show');
                return false;
            }
        });
        $('#mNav_close').click(function()
        {
            mNav.removeClass('show');
        });
    }
});
