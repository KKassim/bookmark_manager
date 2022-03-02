require 'bookmark'

describe Bookmark do
  describe '.all' do
    it 'returns all bookmarks' do
      connection = PG.connect(dbname: 'bookmark_manager_test')

        # Adding test data
      bookmark = Bookmark.create(url: "http://www.makersacademy.com", title: "Makers Academy")

      bookmarks = Bookmark.all
     
      expect(bookmarks.length).to eq 1
      expect(bookmarks.first).to be_a Bookmark
      expect(bookmarks.first.id).to eq bookmark.values[0][0]
      expect(bookmarks.first.title).to eq 'Makers Academy'
      expect(bookmarks.first.url).to eq 'http://www.makersacademy.com'
 
    end
  end

  describe '.create' do
    it 'creates a new bookmark' do
      bookmark = Bookmark.create(url: 'http://www.example.org', title: 'example').first

      expect(bookmark['url']).to eq 'http://www.example.org'
      expect(bookmark['title']).to eq 'example'
    end
  end
end
