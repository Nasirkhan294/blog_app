require 'rails_helper'

RSpec.describe Like, type: :model do
  it 'should update the post like counter' do
    user = User.create(name: 'Misal', posts_counter: 0)
    post = Post.create(author: user, title: 'Hello World')
    like = Like.create(author: user, post:)

    like.update_likes_counter

    expect(post.reload.likes_counter).to eq(1)
  end
end
