require './app'

feature 'Viewing bookmarks' do
  scenario 'visiting the bookmarks page' do
    connection = PG.connect(dbname: 'bookmark_manager_test')
    Bookmark.create(url: 'www.youtube.com', title: 'youtube')
    Bookmark.create(url: 'www.twitter.com', title: 'twitter')
    Bookmark.create(url: 'www.google.com', title: 'google')
    

    visit('/bookmarks')

    expect(page).to have_link('twitter', href: 'www.twitter.com')
    expect(page).to have_link('youtube', href: 'www.youtube.com')
    expect(page).to have_link('google', href: 'www.google.com')  
  end
end
