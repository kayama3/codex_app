require 'json'
require_relative 'task'

class TaskRepository
  FILE_PATH = File.expand_path('../tasks.json', __dir__)

  def initialize(file_path = FILE_PATH)
    @file_path = file_path
    ensure_file_exists
  end

  def all
    JSON.parse(File.read(@file_path)).map { |h| Task.from_h(h) }
  rescue JSON::ParserError
    []
  end

  def save(tasks)
    File.write(@file_path, JSON.pretty_generate(tasks.map(&:to_h)))
  end

  private

  def ensure_file_exists
    File.write(@file_path, '[]') unless File.exist?(@file_path)
  end
end
