require 'rails_helper'

RSpec.describe 'Posts#alls', type: :system do
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

  it 'I can see the user\'s profile picture.' do
    visit "/users/#{@tom.id}/posts"
    expect(page).to have_css("img[src='https://placehold.co/200x133']")
  end

  it 'I can see the user\'s username.' do
    visit "/users/#{@tom.id}/posts"
    expect(page).to have_content('Tom')
  end

  it 'I can see the number of posts the user has written.' do
    visit "/users/#{@tom.id}/posts"
    expect(page).to have_content("Number of posts: #{@tom.posts_counter}")
  end

  it 'I can see a post\'s title.' do
    visit "/users/#{@tom.id}/posts"
    expect(page).to have_content(@first_post.title)
  end

  it 'I can see some of the post\'s body.' do
    visit "/users/#{@tom.id}/posts"
    expect(page).to have_content(@first_post.excerpt)
  end

  it 'I can see the first comments on a post.' do
    visit "/users/#{@tom.id}/posts"
    @first_post.five_recent_comments.each do |comment|
      expect(page).to have_content(comment.text)
    end
  end

  it 'I can see how many comments a post has.' do
    visit "/users/#{@tom.id}/posts"
    expect(page).to have_content("Comments: #{@first_post.comments_counter},")
  end

  it 'I can see how many likes a post has.' do
    visit "/users/#{@tom.id}/posts"
    expect(page).to have_content("Likes: #{@first_post.likes_counter}")
  end

  it 'I can see a section for pagination if there are more posts than fit on the view.' do
    visit "/users/#{@tom.id}/posts"
    post_per_page = 10
    pages = (@posts.length / post_per_page).ceil
    (1..pages).each do |page|
      expect(page).to have_content(page)
    end
  end

  it 'When I click on a post, it redirects me to that post\'s show page.' do
    visit "/users/#{@tom.id}/posts"
    click_link @first_post.title
    expect(page).to have_current_path("/users/#{@tom.id}/posts/#{@first_post.id}")
  end
end
