require 'rails_helper'

RSpec.describe 'Posts#details', type: :system do
  before(:all) do
    Comment.delete_all
    Post.delete_all
    User.delete_all
    @tom = User.create(name: 'Tom', photo: 'https://placehold.co/200x133', bio: 'Teacher from Mexico.',
                       posts_counter: 0)
    @first_post = Post.create(author: @tom, title: 'Hello', text: 'This is my first post', comments_counter: 0,
                              likes_counter: 0)
    @lilly = User.create(name: 'Lilly', photo: 'https://placehold.co/200x133', bio: 'Teacher from Poland.',
                         posts_counter: 0)
    @second_post = Post.create(author: @lilly, title: 'Hi Word!', text: 'Lets talk', comments_counter: 0,
                               likes_counter: 0)
    Comment.create(post: @first_post, author: @lilly, text: 'Hi Tom!')
    Comment.create(post: @second_post, author: @tom, text: 'Hi Lili!')
    @users = User.all
    @posts = Post.all
  end

  it 'I can see the post\'s title.' do
    visit "/users/#{@tom.id}/posts/#{@first_post.id}"
    expect(page).to have_content(@first_post.title)
  end

  it 'I can see who wrote the post.' do
    visit "/users/#{@tom.id}/posts/#{@first_post.id}"
    expect(page).to have_content(@tom.name)
  end

  it 'I can see how many comments it has.' do
    visit "/users/#{@tom.id}/posts/#{@first_post.id}"
    expect(page).to have_content("Comments: #{@first_post.comments_counter},")
  end

  it 'I can see how many likes it has.' do
    visit "/users/#{@tom.id}/posts/#{@first_post.id}"
    expect(page).to have_content("Likes: #{@first_post.likes_counter}")
  end

  it 'I can see the post body.' do
    visit "/users/#{@tom.id}/posts/#{@first_post.id}"
    expect(page).to have_content(@first_post.text)
  end

  it 'I can see the username of each commentor.' do
    visit "/users/#{@tom.id}/posts/#{@first_post.id}"
    @first_post.comments.each do |comment|
      expect(page).to have_content(comment.author.name)
    end
  end

  it 'I can see the comment each commentor left.' do
    visit "/users/#{@tom.id}/posts/#{@first_post.id}"
    @first_post.comments.each do |comment|
      expect(page).to have_content(comment.text)
    end
  end
end
