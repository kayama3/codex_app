class DeleteBookmark
  def initialize(repo)
    @repo = repo
  end

  def call(id)
    @repo.delete(id)
  end
end
