require 'bookmark'

describe Bookmark do
  describe '.all' do
    it 'returns all bookmarks' do
      connection = PG.connect(dbname: 'bookmark_manager_test')

        # Adding test data
      connection.exec("INSERT INTO bookmarks (url) VALUES ('www.youtube.com');")
      connection.exec("INSERT INTO bookmarks (url) VALUES ('www.twitter.com');")
      connection.exec("INSERT INTO bookmarks (url) VALUES ('www.google.com');")

      bookmarks = Bookmark.all

      expect(bookmarks).to include("www.youtube.com")
      expect(bookmarks).to include("www.twitter.com")
      expect(bookmarks).to include("www.google.com")
    end
  end
end
