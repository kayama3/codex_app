require_relative '../../lib/errors'

class ListBookmarks
  ALLOWED_SORTS = %w[created_at title].freeze

  def initialize(repo)
    @repo = repo
  end

  def call(input)
    raise Errors::InvalidInput, 'invalid sort' unless ALLOWED_SORTS.include?(input.sort)
    bookmarks = @repo.all
    bookmarks = bookmarks.select(&:favorite) if input.fav
    bookmarks.sort_by { |b| b.send(input.sort) }
  end
end
