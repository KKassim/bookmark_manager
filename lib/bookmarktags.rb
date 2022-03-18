class BookmarkTag
attr_reader :id, :bookmark_id, :tag_id

    def initialize(id:, bookmark_id:, tag_id:)
        @id = id
        @bookmark_id = bookmark_id
        @tag_id = tag_id
    end

    def self.create
        entries = DatabaseConnection.query("INSERT INTO tags (bookmark_id, tag_id) VALUES ($1, $2) RETURNING id, bookmark_id, tag_id;",
        [bookmark_id, tag_id]
    )
        BookmarkTag.new(
          id: entries[0]['id'],
          bookmark_id: entries[0]['bookmark_id'],
          tag_id: entries[0]['tag_id']
        )
    end
end