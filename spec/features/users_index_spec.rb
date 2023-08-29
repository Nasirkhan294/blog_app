require 'rails_helper'

RSpec.feature 'User Index', type: :feature do
  scenario 'visiting the user index page' do
    User.create(name: 'Tom', photo: 'https://media.gcflearnfree.org/ctassets/topics/246/share_size_large.jpg')
    User.create(name: 'Lily', photo: 'https://media.gcflearnfree.org/ctassets/topics/246/share_size_large.jpg')
    visit users_path
    expect(page).to have_content('Tom')
    expect(page).to have_content('Lily')
  end
  scenario 'User index page, checking each users posts' do
    user1 = User.create(name: 'Tom')
    User.create(name: 'Lily')
    Post.create(author: user1, title: 'first post')
    Post.create(author: user1, title: 'second post')
    Post.create(author: user1, title: 'third post')
    visit users_path
    expect(page).to have_content('3')
    expect(page).to have_content('0')
  end
  scenario 'Redirecting to user show page' do
    user = User.create(name: 'John')
    visit users_path
    click_link 'John'
    expect(page).to have_current_path(user_path(user))
  end
end
