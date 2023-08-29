require 'rails_helper'

describe 'User Show Page', type: :feature do
  scenario "visiting a user's show page" do
    user = User.create(
      name: 'Tom',
      photo: 'https://placehold.co/200x133',
      bio: 'Teacher from Mexico.'
    )

    post1 = Post.create(
      author: user,
      title: 'hello world',
      text: 'This is my first post'
    )

    post2 = Post.create(
      author: user,
      title: 'Hi rails',
      text: 'This is another post'
    )

    Comment.create(
      post: post1,
      author: 'Tom',
      text: 'This is new comment'
    )

    visit user_path(user)

    expect(page).to have_content('Tom')
    expect(page).to have_css("img[src='https://placehold.co/200x133']")
    expect(page).to have_content('Number of posts: 2')

    expect(page).to have_content('hello world')
    expect(page).to have_content('This is my first post')
    expect(page).to have_content('Comments: 1,')
    expect(page).to have_content('Likes: 1')

    expect(page).to have_content('Hi rails')
    expect(page).to have_content('This is another post')
    expect(page).to have_content('Comments: 0,')
    expect(page).to have_content('Likes: 0')

    user.recent_three.each do |post|
      within("a[href='/users/#{user.id}/posts/#{post.id}']") do
        click_link("Post #{post.id}")
      end
      expect(page).to have_current_path(post_path(post))
    end

    click_link('See all posts')
    expect(page).to have_current_path("/users/#{user.id}/posts")
  end
end
