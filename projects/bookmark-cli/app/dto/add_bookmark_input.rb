class AddBookmarkInput
  attr_reader :url, :title

  def initialize(url:, title:)
    @url = url.strip
    @title = title.strip
  end
end
