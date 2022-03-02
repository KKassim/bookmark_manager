require './app'

feature 'Adding a new bookmark' do
  scenario 'A user can add a bookmark to Bookmark Manager' do
    visit('/bookmarks/new')
    fill_in('url', with: 'http://www.example.org')
    fill_in('title', with: 'example')
    click_button('Submit')

    expect(page).to have_link('example', href: 'http://www.example.org')
  end
end
