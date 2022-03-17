class Comment
  attr_reader :id, :text, :bookmark_id

  def initialize(id:, text:, bookmark_id:)
    @id = id
    @text = text
    @bookmark_id = bookmark_id
  end

  def self.create(bookmark_id:, text:)
    entries = DatabaseConnection.query(
        "INSERT INTO comments (bookmark_id, text) VALUES ($1, $2) RETURNING id, text, bookmark_id;",
        [bookmark_id, text]
    )
    Comment.new(
        id: entries[0]['id'],
        text: entries[0]['text'],
        bookmark_id: entries[0]['bookmark_id']
    )
  end

  def self.where(bookmark_id:)
    result =  DatabaseConnection.query( 
        "SELECT * FROM comments WHERE bookmark_id = $1;", 
        [bookmark_id]
    )
    result.map do |comment|
        Comment.new(
            id: comment['id'],
            text: comment['text'],
            bookmark_id: comment['bookmark_id']
        )
    end
  end
end
