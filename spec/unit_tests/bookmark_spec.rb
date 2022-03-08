require 'bookmark'
require 'database_helpers'

describe Bookmark do
  describe '.all' do
    it 'returns all bookmarks' do
      connection = PG.connect(dbname: 'bookmark_manager_test')

      bookmark = Bookmark.create(url: "http://www.makersacademy.com", title: "Makers Academy")
      bookmarks = Bookmark.all
      persisted_data = persisted_data(id: bookmark.id)
     
      expect(bookmarks.length).to eq 1
      expect(bookmarks.first).to be_a Bookmark
      expect(bookmark.id).to eq persisted_data['id']
      expect(bookmarks.first.title).to eq 'Makers Academy'
      expect(bookmarks.first.url).to eq 'http://www.makersacademy.com'
 
    end
  end

  describe '.create' do
    it 'creates a new bookmark' do
      bookmark = Bookmark.create(url: 'http://www.example.org', title: 'example')
      persisted_data = persisted_data(id: bookmark.id)

      expect(bookmark.url).to eq 'http://www.example.org'
      expect(bookmark.title).to eq 'example'
    end
  end

  describe '.delete' do
    it 'deletes the given bookmark' do
      bookmark = Bookmark.create(title: 'Makers Academy', url: 'http://www.makersacademy.com')
  
      Bookmark.delete(id: bookmark.id)
  
      expect(Bookmark.all.length).to eq 0
    end
  end
end