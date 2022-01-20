$(function()
{
    new function() {
        var body  = $('#body');
        var tnav  = $('#tnav');
        /* スマホナビ表示 */
        $('#tnav_open_btn').click(function()
        {
            if (tnav.hasClass('navshow'))
            {
                tnav.removeClass('navshow');
            }
            else
            {
                tnav.addClass('navshow');
            }
            return false;
        });
        body.click(function()
        {
            if (tnav.hasClass('navshow'))
            {
                tnav.removeClass('navshow');
                return false;
            }
        });
    }
});
