( function ($) {
  $.FollowToggle = function (el, options) {
    this.$el = $(el);
    this.userId = this.$el.data("id") || options.userId;
    this.followState = this.$el.data("follow-state") || options.followState;
    this.render();
    this.$el.on('click', this.handleClick.bind(this));
  };

  $.FollowToggle.prototype.render = function () {
    if (this.followState == "unfollowing" || this.followState == "following") {
      this.$el.prop('disabled', true);
    } else {
      if (this.followState == "unfollowed") {
        this.$el.html("Follow");
      } else if (this.followState == "followed") {
        this.$el.html("Unfollow");
      }
      this.$el.prop('disabled', false);
    }
  };

  $.FollowToggle.prototype.handleClick = function (e) {
    e.preventDefault();
    var that = this;
    this.followState = (this.followState == "followed") ? "unfollowing" : "following";
    that.render();
    $.ajax({
      url: '/users/' + that.userId + '/follow',
      type: (that.followState == "unfollowing") ? 'delete' : 'post',
      dataType: 'json',
      success: function () {
        that.followState = (that.followState == "following") ? 'followed' : 'unfollowed';
        that.render();
      }
    })
  };

  $.fn.followToggle = function (options) {
    return this.each(function () {
      new $.FollowToggle(this, options);
    });
  };

  $(function () {
    $("button.follow-toggle").followToggle();
  });
})(jQuery);
