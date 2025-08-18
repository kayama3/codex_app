class ListBookmarksInput
  attr_reader :fav, :sort

  def initialize(fav: false, sort: 'created_at')
    @fav = fav
    @sort = sort
  end
end
