require 'minitest/autorun'

ROOT = File.expand_path('..', __dir__)
$LOAD_PATH.unshift File.join(ROOT, 'app')
$LOAD_PATH.unshift File.join(ROOT, 'domain')
$LOAD_PATH.unshift File.join(ROOT, 'infra')
$LOAD_PATH.unshift File.join(ROOT, 'lib')

require 'entities/bookmark'
require 'repositories/bookmark_repo'
require 'errors'

class FakeBookmarkRepo < BookmarkRepo
  def initialize
    @records = []
    @next_id = 1
  end

  def next_id
    @next_id
  end

  def save(bookmark)
    existing = @records.index { |b| b.id == bookmark.id }
    if existing
      @records[existing] = bookmark
    else
      @records << bookmark
      @next_id = bookmark.id + 1 if bookmark.id >= @next_id
    end
    bookmark
  end

  def find(id)
    b = @records.find { |bk| bk.id == id }
    raise Errors::NotFound, 'not found' unless b
    b
  end

  def all
    @records
  end

  def delete(id)
    b = @records.find { |bk| bk.id == id }
    raise Errors::NotFound, 'not found' unless b
    @records.delete(b)
  end
end
