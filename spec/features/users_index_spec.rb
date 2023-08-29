require 'rails_helper'

RSpec.describe 'Users#index', type: :system do
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

  it 'I can see the username of all other users.' do
    visit '/users'
    expect(page).to have_content('Tom')
    expect(page).to have_content('Lilly')
  end

  it 'I can see the profile picture for each user.' do
    visit '/users'
    @users.each do
      expect(page).to have_css("img[src='https://placehold.co/200x133']")
    end
  end

  it 'I can see the number of posts each user has written.' do
    visit '/users'
    @users.each do |user|
      expect(page).to have_content("Number of posts: #{user.posts_counter}")
    end
  end

  it 'When I click on a user, I am redirected to that user\'s show page.' do
    visit '/users'
    click_link 'Tom'
    expect(page).to have_current_path("/users/#{@tom.id}")
  end
end
