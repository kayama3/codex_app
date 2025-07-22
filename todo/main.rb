#!/usr/bin/env ruby
require_relative 'lib/command_parser'
require_relative 'lib/task_service'

parser = CommandParser.new(ARGV)
command, *params = parser.parse
service = TaskService.new

begin
  case command
  when :list
    service.list
  when :add
    service.add(params.first)
  when :edit
    service.edit(params[0], params[1])
  when :delete
    service.delete(params.first)
  when :toggle
    service.toggle(params.first)
  else
    puts <<~USAGE
      Usage:
        todo list
        todo add "title"
        todo edit ID "new title"
        todo delete ID
        todo toggle ID
    USAGE
  end
rescue StandardError => e
  warn "Error: #{e.message}"
  exit 1
end
