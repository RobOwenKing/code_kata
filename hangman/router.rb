class Router
  def initialize(controller)
    @controller = controller
    @running    = true
  end

  def welcome_text
    puts "Let's play Hangman!"
    puts ' ______    '
    puts ' |    |'
    puts ' |    o'
    puts ' |   /|\\'
    puts ' |   / \\'
    puts '_|______'
    puts "Press '/' or '\\' at any point to quit"
  end

  def main_loop(action)
    case action
    when 'y'
      @controller.new_game
    when 'n', '\\', '/'
      @running = false
    else
      puts 'Say again?'
      p action
    end
  end

  def run
    welcome_text

    while @running
      puts "_____________________"
      puts 'New game? [y/n]'
      action = gets.chomp.downcase
      main_loop(action)
    end
  end
end
