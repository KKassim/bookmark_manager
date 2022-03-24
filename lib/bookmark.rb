require 'pg'
require 'uri'

class Bookmark
  attr_reader :id, :title, :url
    
  def initialize(id:, url:, title:)
    @id = id
    @url = url
    @title = title
  end

  def self.all
    entries = DatabaseConnection.query("SELECT * FROM bookmarks")
    entries.map do |bookmark| 
      Bookmark.new(
          url: bookmark['url'],
          title: bookmark['title'],
          id: bookmark['id']
        )
    end
  end

  def tags(tag_class = Tag)
    tag_class.where(bookmark_id: id)
  end

  def comments(comment_class = Comment)
    comment_class.where(bookmark_id: id)
  end
  
  def self.update(id:, url:, title:)

    entries = DatabaseConnection.query(
      "UPDATE bookmarks SET url = $1, title = $2 WHERE id = $3 RETURNING id, url, title;",
      [url, title, id]
    )
    Bookmark.new(id: entries[0]['id'], title: entries[0]['title'], url: entries[0]['url'])
  end

  def self.delete(id:)
    DatabaseConnection.query("DELETE FROM bookmarks WHERE id = $1", [id])
  end

  def self.find(id:)
    entries = DatabaseConnection.query("SELECT * FROM bookmarks WHERE id = $1;", [id])
    Bookmark.new(id: entries[0]['id'], title: entries[0]['title'], url: entries[0]['url'])
  end

  def self.where(tag_id:)
    result = DatabaseConnection.query("SELECT * FROM bookmark_tags INNER JOIN bookmarks ON bookmarks.id = bookmark_tags.bookmark_id WHERE bookmark_tags.tag_id = '#{tag_id}';")
    result.map do |bookmark|
      Bookmark.new(
        id: bookmark['id'], 
        title: bookmark['title'], 
        url: bookmark['url']
      )
    end
  end

  def self.url?(url)
    url =~ /\A#{URI::regexp(['http', 'https'])}\z/
  end

  def self.create(url:, title:)
    return false unless url?(url)
  
    entries = DatabaseConnection.query(
        "INSERT INTO bookmarks (url, title) VALUES($1, $2) RETURNING id, title, url;", 
        [url, title]
      )
    Bookmark.new(id: entries[0]['id'], 
      title: entries[0]['title'], 
      url: entries[0]['url']
    )
end

end
