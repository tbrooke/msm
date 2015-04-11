//$(document).ready(function() {
//    var menuToggle = $('#js-centered-navigation-mobile-menu').unbind();
//    $('#js-centered-navigation-menu').removeClass("show");
//
//    menuToggle.on('click', function(e) {
//        e.preventDefault();
//        $('#js-centered-navigation-menu').slideToggle(function(){
//            if($('#js-centered-navigation-menu').is(':hidden')) {
//                $('#js-centered-navigation-menu').removeAttr('style');
//            }
//        });
//    });
//});

$(document).ready(function() {
    if ($("#js-parallax-window").length) {
        parallax();
    }
});

$(window).scroll(function(e) {
    if ($("#js-parallax-window").length) {
        parallax();
    }
});

function parallax(){
    if( $("#js-parallax-window").length > 0 ) {
        var plxBackground = $("#js-parallax-background");
        var plxWindow = $("#js-parallax-window");

        var plxWindowTopToPageTop = $(plxWindow).offset().top;
        var windowTopToPageTop = $(window).scrollTop();
        var plxWindowTopToWindowTop = plxWindowTopToPageTop - windowTopToPageTop;

        var plxBackgroundTopToPageTop = $(plxBackground).offset().top;
        var windowInnerHeight = window.innerHeight;
        var plxBackgroundTopToWindowTop = plxBackgroundTopToPageTop - windowTopToPageTop;
        var plxBackgroundTopToWindowBottom = windowInnerHeight - plxBackgroundTopToWindowTop;
        var plxSpeed = 0.35;

        plxBackground.css('top', - (plxWindowTopToWindowTop * plxSpeed) + 'px');
    }
}

(function (jQuery) {
    jQuery.mark = {
        jump: function (options) {
            var defaults = {
                selector: 'a.scroll-on-page-link'
            };
            if (typeof options == 'string') {
                defaults.selector = options;
            }

            options = jQuery.extend(defaults, options);
            return jQuery(options.selector).click(function (e) {
                var jumpobj = jQuery(this);
                var target = jumpobj.attr('href');
                var thespeed = 1000;
                var offset = jQuery(target).offset().top;
                jQuery('html,body').animate({
                    scrollTop: offset
                }, thespeed, 'swing');
                e.preventDefault();
            });
        }
    };
})(jQuery);


jQuery(function(){
    jQuery.mark.jump();
});

