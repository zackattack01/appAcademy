class TagTopic < ActiveRecord::Base
  has_many(
    :taggings,
    foreign_key: :tag_topic_id,
    primary_key: :id,
    class_name: 'Tagging'
  )

  has_many(
    :urls,
    through: :taggings,
    source: :url
  )
end
