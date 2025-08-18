require_relative '../test_helper'
require 'use_cases/toggle_favorite'

class ToggleFavoriteTest < Minitest::Test
  def setup
    @repo = FakeBookmarkRepo.new
    b1 = Bookmark.new(id: 1, url: 'https://a.com', title: 'A', favorite: false, created_at: Time.now.utc)
    @repo.save(b1)
    @use_case = ToggleFavorite.new(@repo)
  end

  def test_toggle_success
    @use_case.call(1, true)
    assert @repo.find(1).favorite
  end

  def test_toggle_not_found
    assert_raises(Errors::NotFound) { @use_case.call(2, true) }
  end
end
