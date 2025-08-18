require_relative '../../domain/entities/bookmark'
require_relative '../../lib/errors'

class AddBookmark
  def initialize(repo)
    @repo = repo
  end

  def call(input)
    id = @repo.next_id
    bookmark = Bookmark.new(id: id, url: input.url, title: input.title,
                            favorite: false, created_at: Time.now.utc)
    @repo.save(bookmark)
    bookmark
  end
end
