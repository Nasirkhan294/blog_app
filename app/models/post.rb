class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, likes, foreign_key: :author_id
end
