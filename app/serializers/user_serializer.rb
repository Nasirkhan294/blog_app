class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :posts_counter, :email, :role
  has_many :posts
end
