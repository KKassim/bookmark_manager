feature 'Adding a new bookmark' do
  scenario 'A user can add a bookmark to Bookmark Manager' do
    visit('/bookmarks/new')
    fill_in('url', with: 'http://www.example.org')
    fill_in('title', with: 'example')
    click_button('Submit')

    expect(page).to have_link('example', href: 'http://www.example.org')
  end

  scenario 'The bookmark must be a valid URL' do
    visit('/bookmarks/new')
    fill_in('url', with: 'not a real URL')
    fill_in('title', with: 'not a real URL')
    click_button('Submit')

    expect(page).not_to have_content('not a real URL')
    expect(page).to have_content('You must submit a valid URL.')
  end
end
