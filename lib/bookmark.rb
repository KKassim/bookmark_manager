require 'pg'

class Bookmark
  attr_reader :id, :title, :url
    
  def initialize(id:, url:, title:)
    @id = id
    @url = url
    @title = title
  end

  def self.all
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end
    result = connection.exec("SELECT * FROM bookmarks")
    result.map do |bookmark|
      Bookmark.new(id: bookmark['id'], title: bookmark['title'], url: bookmark['url'])
    end
  end

  def self.create(url:, title:)
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else 
      connection = PG.connect(dbname: 'bookmark_manager')
    end

    connection.exec("INSERT INTO bookmarks (url, title) VALUES('#{url}', '#{title}') RETURNING id, url, title")
  end
end
