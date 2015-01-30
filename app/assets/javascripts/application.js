// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require magnific-popup
//= require_tree .
//= require_self

$(document).ready(function(){

    // Stretch the video so it always fills the screen
    // in a decent aspect ratio
    if ($('.hero').length > 0) {
        $(window).resize(resizePlayer);
        $(window).resize();

        $('.hero a.fullscreen').magnificPopup({
            type: 'iframe',
            iframe: {
                patterns: {
                    youtube: {
                        // We need to reparse the url because we are saving direct video
                        // embed urls and not the iframe url.
                        id: function(url) {
                            var m = url.match(/^.+youtube.com\/v\/([^_]+)\?/);
                            if (m !== null) {
                                if (m[1] !== undefined) {
                                    return m[1];
                                }
                            }
                            return null;
                        }
                    }
                }
            }
        });

    }

    function resizePlayer() {

        // yt ad takes up 106px at the bottom, take it into account
        // when covering the area.
        var boxWidth = $('.hero').width(),
            boxHeight = $('.hero').height(),
            marginSize = 200;
            adjustedHeight = boxWidth  * 9 / 16;

        $('.hero').height(adjustedHeight + "px");

        $('.hero .video')
            .height(adjustedHeight  + (marginSize*2))
            .css('top', -marginSize + 'px')
            .width(boxWidth  + ((marginSize*2) * 9 / 16))
            .css('left', -marginSize + 'px');

    }


    // Create the video popup for youtube thumbnails
    $('.video-highlights-list').magnificPopup({
        delegate: 'article',
        type: 'iframe',
        iframe: {
            patterns: {
                youtube: {
                    // We need to reparse the url because we are saving direct video
                    // embed urls and not the iframe url.
                    id: function(url) {
                        var m = url.match(/^.+youtube.com\/v\/([^_]+)\?/);
                        if (m !== null) {
                            if (m[1] !== undefined) {
                                return m[1];
                            }
                        }
                        return null;
                    }
                }
            }
        }
    });

    // The calendar timezone switcher
    $('#schedule-timezone').change(function(){
        $('#calendar').attr('src', $(this).val());
    });
});


window.onYouTubePlayerAPIReady = function() {
    new YT.Player('hero-yt-player', {
        playerVars: {
            'autoplay': 1,
            'autohide': 1,
            'cc_load_policy' : 0,
            'controls': 0,
            'disablekb':1,
            'fs':0,
            'loop':1,
            'rel' : 0,
            'showinfo': 0,
            'start':50
        },
        events: {
            onReady : function(event) {
                event.target.loadVideoByUrl(event.target.d.getAttribute('data-video-url'), 40);
                event.target.playVideo();
                event.target.mute();
            }
        }
    });
};
