require './app'

feature 'Viewing bookmarks' do
  scenario 'visiting the bookmarks page' do
    connection = PG.connect(dbname: 'bookmark_manager_test')
    Bookmark.create(url: 'http://www.youtube.com', title: 'youtube')
    Bookmark.create(url: 'http://www.twitter.com', title: 'twitter')
    Bookmark.create(url: 'http://www.google.com', title: 'google')
    

    visit('/bookmarks')

    expect(page).to have_link('twitter', href: 'http://www.twitter.com')
    expect(page).to have_link('youtube', href: 'http://www.youtube.com')
    expect(page).to have_link('google', href: 'http://www.google.com')  
end
end
