require_relative './database_connection'

class Tag

  attr_reader :id, :content

  def initialize(id:, content:)
    @id = id
    @content = content
  end

  def self.create(content:)
    entries = DatabaseConnection.query(      
      "SELECT * FROM tags WHERE content = $1;", [content]
    ).first
    if !entries
        entries = DatabaseConnection.query(
          "INSERT INTO tags (content) VALUES($1) RETURNING id, content;", [content]
        ).first
      end
      Tag.new(
          id: entries['id'], 
          content: entries['content']
        )
  end

  def self.where(bookmark_id:)
    entries = DatabaseConnection.query(
        "SELECT * FROM bookmark_tags INNER JOIN tags ON tags.id = bookmark_tags.tag_id WHERE bookmark_tags.bookmark_id = $1",
        [bookmark_id]
    )
    entries.map do |tag|
      Tag.new(
          id: tag['id'], 
          content: tag['content']
        )
    end
  end

  def self.find(id:)
    result = DatabaseConnection.query("SELECT * FROM tags WHERE id = #{id};")
    Tag.new(
        id: result[0]['id'], 
        content: result[0]['content']
    )
  end

  def bookmarks(bookmark_class = Bookmark)
    bookmark_class.where(tag_id: id)
  end
end
