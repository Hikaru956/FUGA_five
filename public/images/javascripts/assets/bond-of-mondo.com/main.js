$(function()
{
    new function() {
        $('#gNavOpener').click(function()
        {
            $('#gNavWrap').addClass('show');
            $('#gNav').addClass('show');
            return false;
        });
        $('#gNavWrap').click(function()
        {
            $('#gNavWrap').removeClass('show');
            $('#gNav').removeClass('show');
        });
    }
});
$(function()
{
    new function() {
        $('#sNavOpener').click(function()
        {
            $('#gNavWrap').addClass('show');
            $('#gNav').addClass('show');
            return false;
        });
        $('#gNavWrap').click(function()
        {
            $('#gNavWrap').removeClass('show');
            $('#gNav').removeClass('show');
        });
    }
});
