( function ($) {
  $.UserSearch = function (el) {
    this.$el = $(el);
    // var input = this.$el.find("input").val();
    this.$ul = $("ul.users");
    $('.5w4gForNa7i0n').on("input", this.handleInput.bind(this)) //install event handler
  };

  $.UserSearch.prototype.handleInput = function(event) {
    // debugger
    event.preventDefault(); //may not need bc no submit button
    var input = this.$el.find("input").val();
    var formData = {query: input};
    var that = this;
    $.ajax({
      url: "/users/search",
      type: "get",
      dataType: 'json',
      data: formData,
      success: function(people, statusText, jqXHR) {
        that.renderResults(people);
      }

    });
  };

  $.UserSearch.prototype.renderResults = function(persons) {
    this.$ul.children().remove(); // emptys out the ul
    var that = this;
    persons.forEach( function(person) {
      var $li = $("<li></li>");
      $li.append("<a href=/users/" + person.id + "/ >" + person.username + "</a>");
      var followState = person.followed ? "followed" : "unfollowed";
      var $button = $("<button class='follow-toggle'></button>");
      $button.followToggle({userId: person.id, followState: followState});
      $li.append($button);
      that.$ul.append($li);
      // debugger
    } )
  };

  $.fn.userSearch = function () {
    return this.each(function () {
      new $.UserSearch(this);
    });
  };

  $(function () {
    $("div.users-search").userSearch();
  });
})(jQuery);
