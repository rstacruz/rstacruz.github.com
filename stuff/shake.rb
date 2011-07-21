## Shake
# Shake is a very simple Thor/Rake replacement. It intends
# to replicate thor's basic functionality in <100loc.

### Example
# This is a very simple example.

require 'shake'

Shake.task(:hello) {
  puts "hi, #{params.join(' ')}!"
}

Shake.run!

# Example output:
#
#    $ ./example
#    Usage: example <command>
#    
#    Commands:
#      help
#      hello
#    
#    $ ./example hello world
#    hi, world!
#    
#    $ ./example aaaa
#    Unknown command: aaaa
#    See `example help` for a list of commands.

### Example 2: monk
# This is a very simple example of using Shake with a subclass.

require 'shake'

class Monk < Shake
  # Include the Shake default commands (like `help` and stuff)
  # This is optional, but you probably want this for most cases.
  include Defaults

  # Define a task like this.
  # The other command line options will be accesible as the
  # `params` array. Pass it onto Clap or something.
  task(:start) {
    puts "Running..."
    puts "Your options: #{params.inspect}"
  }

  # Just `task` will return the last defined task.
  # By the way, only `help` cares about the description (skip
  # it if you wish), and you can add as much metadata to the
  # tasks as you need.
  task.description = "Starts the server"

  # You may also define task metadata like this.
  # Note that there are no namespaces, but feel free to use
  # the colon anyway.
  task(:'redis:start', :description => "Runs redis") {
    puts "Starting redis..."
  }

  # Or this way:
  task(:stop) {
    puts "Stopping..."
  }

  task(:stop).description = "Stops the server"
end

# This gets ARGV, and dispatches the appropriate task.
Monk.run!

# Example output:
#
#    $ ./monk
#    Usage: monk <command>
#    
#    Commands:
#      help           Shows a list of commands
#      start          Starts the server
#      redis:start    Runs redis
#      stop           Stops the server
#    
#    $ ./monk start production
#    Running...
#    Your options: ['production']
#    
#    $ ./monk aaaa
#    Unknown command: aaaa
#    See `monk help` for a list of commands.

## shake.rb
# Now onto Shake itself!

require 'ostruct'

class Shake
  # By the way: every task gets evaluated in the context of the class.
  # Just make more static methods (`def self.monkey`) if you need them
  # in your tasks.
  class << self
    attr_reader :params
    attr_reader :command

    # Returns a list of tasks.
    # It gives out a hash with symbols as keys, and openstructs as values.
    def tasks
      @tasks ||= Hash.new
    end

    # Sets or retrieves a task.
    # If no arguments are given, it returns the last task defined.
    #
    # Examples:
    #
    #     task(:start) { ... }
    #     task(:start, description: 'Starts it') { ... }
    #     invoke task(:start)
    #     task.description = "Starts it"
    #
    def task(what=nil, options={}, &blk)
      return @last  if what.nil?

      key = what.downcase.to_sym
      @last = tasks[key] = new_task(options, &blk)  if block_given?
      tasks[key]
    end

    # Sets or retrieves the default task.
    #
    # Examples:
    #
    #     default :default_task
    #     default { ... }
    #
    def default(what=nil, &blk)
      @default = what || blk || @default
    end

    # Sets or retrieves the 'invalid command' task.
    # See `default` for examples.
    def invalid(what=nil, &blk)
      @invalid = what || blk || @invalid
    end

    # Invokes a task with the given arguments.
    # You may even nest multiple task invocations.
    #
    # Examples:
    #
    #    invoke(:start)
    #    invoke(:start, 'nginx', 'memcache')
    #
    def invoke(what, *args)
      old, @params = @params, args

      begin
        return instance_eval(&what)  if what.is_a?(Proc)

        task  = task(what)  or return nil
        instance_eval &task.proc
        true
      ensure
        @params = old
      end
    end

    # Runs with the given arguments and dispatches the appropriate task.
    # Use `run!` if you want to go with command line arguments.
    #
    # Example:
    #
    #     # This is equivalent to `invoke(:start, 'nginx')`
    #     run 'start', 'nginx'
    #
    def run(*argv)
      return invoke(default)  if argv.empty?

      @command = argv.shift
      invoke(@command, *argv) or invoke(invalid)
    end

    def run!
      run *ARGV
    end

    def executable
      File.basename($0)
    end

    def err(str="")
      $stderr.write "#{str}\n"
    end

  protected
    def new_task(options={}, &blk)
      t = OpenStruct.new(options)
      t.proc = blk
      t
    end
  end

  # This is a list of default commands.
  # The class Shake itself uses this, but if you subclass it,
  # you will have to do `include Defaults` yourself.
  module Defaults
    def self.included(to)
      to.default :help

      to.task(:help) {
        err "Usage: #{executable} <command>"
        err
        err "Commands:"
        tasks.each { |name, task| err "  %-20s %s" % [ name, task.description ] }
      }

      to.task(:help).description = "Shows a list of commands"

      to.invalid {
        err "Unknown command: #{command}"
        err "See `#{executable} help` for a list of commands."
      }
    end
  end

  include Defaults
end
