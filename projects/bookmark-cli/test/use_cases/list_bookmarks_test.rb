require_relative '../test_helper'
require 'dto/list_bookmarks_input'
require 'use_cases/list_bookmarks'

class ListBookmarksTest < Minitest::Test
  def setup
    @repo = FakeBookmarkRepo.new
    @use_case = ListBookmarks.new(@repo)
    b1 = Bookmark.new(id: 1, url: 'https://a.com', title: 'A', favorite: true, created_at: Time.utc(2020))
    b2 = Bookmark.new(id: 2, url: 'https://b.com', title: 'B', favorite: false, created_at: Time.utc(2021))
    @repo.save(b1)
    @repo.save(b2)
  end

  def test_list_favorites
    input = ListBookmarksInput.new(fav: true, sort: 'created_at')
    list = @use_case.call(input)
    assert_equal 1, list.size
    assert list.first.favorite
  end

  def test_invalid_sort
    input = ListBookmarksInput.new(sort: 'invalid')
    assert_raises(Errors::InvalidInput) { @use_case.call(input) }
  end
end
