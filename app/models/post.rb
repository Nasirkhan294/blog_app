class Post < ApplicationRecord
  after_save :update_posts_counter
  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def five_recent_comments
    comments.includes(:author).order(created_at: :desc).limit(5)
  end

  # validations
  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :likes_counter, numericality: { greater_than_or_equal_to: 0, only_integer: true }

  def excerpt
    return text unless text.length > 50

    "#{text.slice(0, 50)} ..."
  end
  
  def update_posts_counter
    author.update(posts_counter: author.posts.count)
  end
end
