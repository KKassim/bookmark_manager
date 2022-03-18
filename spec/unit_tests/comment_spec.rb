require 'database_helpers'
require 'comment'
require 'bookmark'

describe Comment do
  describe '.create' do
    it 'creates a new comment' do
      bookmark = Bookmark.create(url: "http://www.makersacademy.com", title: "Makers Academy")
      comment = Comment.create(text: 'This is a test comment', bookmark_id: bookmark.id)

      persisted_data = persisted_data(table: 'comments', id: comment.id)
      expect(comment).to be_a Comment
      expect(comment.id).to eq persisted_data['id']
      
      expect(comment.text).to eq 'This is a test comment'
      expect(comment.bookmark_id).to eq bookmark.id
    end

    it 'gets the comments related to a specific bookmark' do
      bookmark = Bookmark.create(url: "http://www.makersacademy.com", title: "Makers Academy")
      comment = Comment.create(text: 'This is a test comment', bookmark_id: bookmark.id)

      bookmark_comments = Comment.where(bookmark_id: bookmark.id)
      comment = bookmark_comments.first
      persisted_data = persisted_data(table: 'comments', id: comment.id)

      expect(bookmark_comments.length).to eq 1
      expect(comment.id).to eq persisted_data['id']
      expect(comment.text).to eq 'This is a test comment'
      expect(comment.bookmark_id).to eq bookmark.id
    end
  end
end
