require './app'

feature 'Viewing bookmarks' do
  scenario 'visiting the bookmarks page' do
    connection = PG.connect(dbname: 'bookmark_manager_test')

    connection.exec("INSERT INTO bookmarks (url) VALUES ('www.twitter.com');")
    connection.exec("INSERT INTO bookmarks (url) VALUES ('www.youtube.com');")
    connection.exec("INSERT INTO bookmarks (url) VALUES ('www.google.com');")

    visit('/bookmarks')
    expect(page).to have_content "www.twitter.com"
    expect(page).to have_content "www.youtube.com"
    expect(page).to have_content "www.google.com"
  end
end
