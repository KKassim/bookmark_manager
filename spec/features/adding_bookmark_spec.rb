require './app'

feature 'Add a new bookmark' do
    scenario 'user presses submit button for a url' do
        connection = PG.connect(dbname: 'bookmark_manager_test')

        connection.exec("INSERT INTO bookmarks (url) VALUES ('http://example.org');")
        visit('/bookmarks/new')
        fill_in('url', with: 'http://example.org')
        click_button('Submit')



        expect(page).to have_content('http://example.org')
    end
end