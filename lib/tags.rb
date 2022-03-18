class Tag

attr_reader :id, :content

    def initialize(id:, content:)
        @id = id
        @content = content
    end

    def self.create(content:)
        entries = DatabaseConnection.query("INSERT INTO tags (content) VALUES ($1) RETURNING id, content;",
        [content]
    )
        Tag.new(
          id: entries[0]['id'],
          content: entries[0]['content']
        )
    end

    def self.where(bookmark_id:)
        entries = DatabaseConnection.query(
            "SELECT id, content FROM bookmark_tags INNER JOIN tags ON tags.id = bookmark_tags.tag_id WHERE bookmark_tags.bookmark_id = $1",
            [bookmark_id]
        )
        entries.map do |tag|
            Tag.new(id: tag['id'], content: tag['content'])
        end
    end
end