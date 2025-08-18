class ToggleFavorite
  def initialize(repo)
    @repo = repo
  end

  def call(id, to)
    bookmark = @repo.find(id)
    bookmark.toggle_favorite(to: to)
    @repo.save(bookmark)
    bookmark
  end
end
