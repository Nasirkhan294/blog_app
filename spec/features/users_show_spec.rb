require 'rails_helper'

RSpec.describe 'Users#shows', type: :system do
  before(:all) do
    Comment.delete_all
    Post.delete_all
    User.delete_all
    @tom = User.create(name: 'Tom', photo: 'https://placehold.co/200x133', bio: 'Teacher from Mexico.',
                       posts_counter: 0)
    Post.create(author: @tom, title: 'Hello', text: 'This is my first post', comments_counter: 0, likes_counter: 0)
    @lilly = User.create(name: 'Lilly', photo: 'https://placehold.co/200x133', bio: 'Teacher from Poland.',
                         posts_counter: 0)
    @users = User.all
  end

  it 'I can see the user\'s profile picture..' do
    visit "/users/#{@tom.id}"
    expect(page).to have_css("img[src='https://placehold.co/200x133']")
  end

  it 'I can see the user\'s username.' do
    visit "/users/#{@tom.id}"
    expect(page).to have_content('Tom')
  end

  it 'I can see the number of posts the user has written.' do
    visit "/users/#{@tom.id}"
    expect(page).to have_content('Number of posts: 1')
  end

  it 'I can see the user\'s bio.' do
    visit "/users/#{@tom.id}"
    expect(page).to have_content('Teacher from Mexico.')
  end

  it 'I can see the user\'s first 3 posts.' do
    visit "/users/#{@tom.id}"
    posts = @users[0].recent_three
    posts.each do |post|
      expect(page).to have_content(post.title)
    end
  end

  it 'I can see a button that lets me view all of a user\'s posts.' do
    visit "/users/#{@tom.id}"
    expect(page).to have_content('See all posts')
  end

  it 'When I click a user\'s post, it redirects me to that post\'s show page.' do
    visit "/users/#{@tom.id}"
    posts = @users[0].recent_three
    unless posts.nil? || posts.empty?
      click_link posts[0].title
      expect(page).to have_current_path("/users/#{@tom.id}/posts/#{posts[0].id}")
    end
  end

  it 'When I click to see all posts, it redirects me to the user\'s post\'s index page.' do
    visit "/users/#{@tom.id}"
    click_link 'See all posts'
    expect(page).to have_current_path("/users/#{@tom.id}/posts")
  end
end
