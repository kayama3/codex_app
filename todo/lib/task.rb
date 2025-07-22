class Task
  attr_accessor :id, :title, :completed

  def initialize(id:, title:, completed: false)
    @id = id
    @title = title
    @completed = completed
  end

  def to_h
    { 'id' => @id, 'title' => @title, 'completed' => @completed }
  end

  def self.from_h(hash)
    new(id: hash['id'], title: hash['title'], completed: hash['completed'])
  end
end
