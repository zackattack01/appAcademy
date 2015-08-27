(function ($) {

  $.TweetCompose





  $.fn.tweetCompose = function () {
    return this.each(function () {
      new $.TweetCompose(this);
    });
  };

  $(function () {
    $('.feed').tweetCompose();
  });
})(jQuery);
