require 'json'
require 'time'
require_relative '../../lib/errors'
require_relative '../../domain/entities/bookmark'
require_relative '../../domain/repositories/bookmark_repo'

class FileBookmarkRepo < BookmarkRepo
  def initialize(path)
    @path = path
  end

  def next_id
    all_bookmarks = load_records
    max = all_bookmarks.map(&:id).max || 0
    max + 1
  end

  def save(bookmark)
    bookmarks = load_records
    index = bookmarks.index { |b| b.id == bookmark.id }
    if index
      bookmarks[index] = bookmark
    else
      bookmarks << bookmark
    end
    write_records(bookmarks)
    bookmark
  end

  def find(id)
    b = load_records.find { |bk| bk.id == id }
    raise Errors::NotFound, "Bookmark #{id} not found" unless b
    b
  end

  def all
    load_records
  end

  def delete(id)
    bookmarks = load_records
    removed = bookmarks.reject! { |b| b.id == id }
    raise Errors::NotFound, "Bookmark #{id} not found" unless removed
    write_records(bookmarks)
  end

  private

  def load_records
    data = read_json
    data.map do |h|
      Bookmark.new(id: h['id'], url: h['url'], title: h['title'],
                   favorite: h['favorite'], created_at: Time.iso8601(h['created_at']))
    end
  end

  def read_json
    return [] unless File.exist?(@path)
    content = File.read(@path, encoding: 'UTF-8')
    JSON.parse(content)
  rescue StandardError => e
    raise Errors::StorageError, e.message
  end

  def write_records(bookmarks)
    records = bookmarks.map do |b|
      {
        id: b.id,
        url: b.url,
        title: b.title,
        favorite: b.favorite,
        created_at: b.created_at.utc.iso8601
      }
    end
    tmp = @path + '.tmp'
    File.open(tmp, 'w', encoding: 'UTF-8') { |f| f.write(JSON.dump(records)) }
    File.rename(tmp, @path)
  rescue StandardError => e
    raise Errors::StorageError, e.message
  end
end
