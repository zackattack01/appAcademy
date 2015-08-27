Journal.Collections.Posts = Backbone.Collection.extend({
  model: Journal.Models.Post,

  url: '/posts',

  getOrFetch: function(id) {
    var collection = this;
    var post = this.get(id);
    if (!post) {
      post = new Journal.Models.Post({ id: id });
      collection.add(post);
    }
    post.fetch();
    return post;
  }
})