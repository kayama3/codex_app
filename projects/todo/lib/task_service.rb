require_relative 'task_repository'

class TaskService
  def initialize(repository = TaskRepository.new)
    @repository = repository
  end

  def list
    tasks = @repository.all.sort_by(&:id)
    tasks.each do |task|
      status = task.completed ? '[x]' : '[ ]'
      puts "#{task.id}: #{status} #{task.title}"
    end
  end

  def add(title)
    raise 'Title cannot be empty' if title.to_s.strip.empty?

    tasks = @repository.all
    new_id = tasks.map(&:id).max.to_i + 1
    tasks << Task.new(id: new_id, title: title, completed: false)
    @repository.save(tasks)
    puts "Added task #{new_id}"
  end

  def edit(id, new_title)
    raise 'Title cannot be empty' if new_title.to_s.strip.empty?

    tasks = @repository.all
    task = tasks.find { |t| t.id == id }
    raise "Task #{id} not found" unless task

    task.title = new_title
    @repository.save(tasks)
    puts "Edited task #{id}"
  end

  def delete(id)
    tasks = @repository.all
    task = tasks.find { |t| t.id == id }
    raise "Task #{id} not found" unless task

    tasks.delete(task)
    @repository.save(tasks)
    puts "Deleted task #{id}"
  end

  def toggle(id)
    tasks = @repository.all
    task = tasks.find { |t| t.id == id }
    raise "Task #{id} not found" unless task

    task.completed = !task.completed
    @repository.save(tasks)
    status = task.completed ? 'completed' : 'incomplete'
    puts "Task #{id} marked as #{status}"
  end
end
