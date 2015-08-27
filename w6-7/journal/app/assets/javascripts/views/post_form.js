Journal.Views.PostForm = Backbone.View.extend({
  template: JST['post_form'],

  events: {
    'click button.submit-post': 'updatePost'
  },

  updatePost: function() {
    var formData = $('#post-form').serializeJSON();
    var post = this.model;
    post.set(formData.post);
    var that = this;
    post.save({}, {
      success: function(resp) {
        that.collection.add(post);
        Backbone.history.navigate('/posts/' + post.get('id'), {trigger: true});
      },

      error: function(resp) {
        this.$el.prepend(resp)
      }
    });

  },

  render: function() {
    var content = this.template({ post: this.model });
    this.$el.html(content);
    return this;
  }
})