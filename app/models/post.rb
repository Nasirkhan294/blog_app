class Post < ApplicationRecord
  after_save :update_posts_counter
  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def recent_five
    comments.order(created_at: :desc).limit(5)
  end

  # validations
  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :likes_counter, numericality: { greater_than_or_equal_to: 0, only_integer: true }

  def update_posts_counter
    author.update(posts_counter: author.posts.count)
  end
end
