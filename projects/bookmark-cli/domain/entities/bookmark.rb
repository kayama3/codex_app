require 'uri'
require_relative '../../lib/errors'

class Bookmark
  attr_reader :id, :url, :title, :favorite, :created_at

  def initialize(id:, url:, title:, favorite: false, created_at: Time.now.utc)
    @id = id
    @url = url.strip
    @title = title.strip
    @favorite = favorite
    @created_at = created_at
    validate!
  end

  def toggle_favorite(to:)
    @favorite = to
  end

  private

  def validate!
    raise Errors::InvalidInput, 'title cannot be empty' if @title.empty?
    unless @url.start_with?('http://', 'https://')
      raise Errors::InvalidInput, 'url must start with http:// or https://'
    end
  end
end
