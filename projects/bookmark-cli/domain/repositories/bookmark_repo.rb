class BookmarkRepo
  def next_id
    raise NotImplementedError
  end

  def save(bookmark)
    raise NotImplementedError
  end

  def find(id)
    raise NotImplementedError
  end

  def all
    raise NotImplementedError
  end

  def delete(id)
    raise NotImplementedError
  end
end
