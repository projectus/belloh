function initialize_post_form() {

    var $mood_option = $('.mood-option');

    $mood_option.click(function(){
        var mood = $(this).attr('mood');
        $('#new_post_box').attr('mood',mood);
        $("#mood").val(mood);
    });

    $('.input-prepend').each(function(){
        var $textarea = $(this).find('textarea');
        var $span = $(this).find('span.add-on');
        var $submit_label = $(this).find("label[for=commit]");
        var ta_height = $textarea.outerHeight();

        var span_height = parseInt($span.css('padding-top'))+
            parseInt($span.css('padding-bottom'))+
            parseInt($span.css('margin-top'))+
            parseInt($span.css('margin-bottom'));

        var submit_height = parseInt($submit_label.css('padding-top'))+
            parseInt($submit_label.css('padding-bottom'))+
            parseInt($submit_label.css('margin-top'))+
            parseInt($submit_label.css('margin-bottom'));

        $span.height(ta_height-span_height);
        $submit_label.height(ta_height-submit_height-2);
    });

    $mood_option.bind("mouseover", function(){
        $(this).css("opacity", "1");
    }).bind("mouseout", function(){
        $(this).css("opacity", "0.7");
    });
}