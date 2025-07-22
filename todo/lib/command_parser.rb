class CommandParser
  def initialize(args)
    @args = args.dup
  end

  def parse
    command = @args.shift
    case command
    when 'list'
      [:list]
    when 'add'
      title = @args.join(' ')
      [:add, title]
    when 'edit'
      id = integer_arg(@args.shift)
      title = @args.join(' ')
      [:edit, id, title]
    when 'delete'
      id = integer_arg(@args.shift)
      [:delete, id]
    when 'toggle'
      id = integer_arg(@args.shift)
      [:toggle, id]
    else
      [:help]
    end
  end

  private

  def integer_arg(arg)
    Integer(arg)
  rescue ArgumentError, TypeError
    raise 'ID must be an integer'
  end
end
