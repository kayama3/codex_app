require_relative '../test_helper'
require 'dto/add_bookmark_input'
require 'use_cases/add_bookmark'

class AddBookmarkTest < Minitest::Test
  def setup
    @repo = FakeBookmarkRepo.new
    @use_case = AddBookmark.new(@repo)
  end

  def test_add_success
    input = AddBookmarkInput.new(url: 'https://example.com', title: 'Example')
    bookmark = @use_case.call(input)
    assert_equal 1, bookmark.id
    assert_equal 'https://example.com', bookmark.url
  end

  def test_add_invalid_title
    input = AddBookmarkInput.new(url: 'https://example.com', title: ' ')
    assert_raises(Errors::InvalidInput) { @use_case.call(input) }
  end
end
