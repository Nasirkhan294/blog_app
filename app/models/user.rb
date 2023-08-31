class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_many :posts, foreign_key: :author_id
  has_many :comments, foreign_key: :author_id
  has_many :likes, foreign_key: :author_id

  validates :name, presence: true
  validates :posts_counter, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :role, inclusion: { in: %w[admin user], message: '%<value>s is not a valid role [admin, user]' }

  before_create :default_posts_counter

  def is?(requested_role)
    role == requested_role.to_s
  end

  def default_posts_counter
    posts_counter || 0
  end

  def three_recent_posts
    posts.order(created_at: :desc).limit(3)
  end
end
