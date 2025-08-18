require_relative '../test_helper'
require 'use_cases/delete_bookmark'

class DeleteBookmarkTest < Minitest::Test
  def setup
    @repo = FakeBookmarkRepo.new
    b1 = Bookmark.new(id: 1, url: 'https://a.com', title: 'A', created_at: Time.now.utc)
    @repo.save(b1)
    @use_case = DeleteBookmark.new(@repo)
  end

  def test_delete_success
    @use_case.call(1)
    assert_empty @repo.all
  end

  def test_delete_not_found
    assert_raises(Errors::NotFound) { @use_case.call(2) }
  end
end
