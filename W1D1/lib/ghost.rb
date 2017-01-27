require_relative 'player.rb'

class Game
  def initialize(player_one, player_two, dictionary)
    @player_one = player_one
    @player_two = player_two
    @fragments = ""
    @dictionary = File.readlines(dictionary)
    @current_player = @player_one
  end
  attr_reader :fragments
  attr_writer :current_player, :previous_player

  def play_round
    until round_over?
      take_turn(@current_player)
      next_player!
    end
    ##add letter to prev player
  end

  def round_over?
    @dictionary.include?(@fragments + "\n")
  end

  def next_player!
    @current_player == @player_one ? @current_player = @player_two : @current_player = @player_one
  end

  def valid_play?(string)
    ("a".."z").cover?(string.downcase) && @dictionary.join("").include?(@fragments + string)
  end

  def take_turn(player)

    string = ""
    until valid_play?(string)
      string = player.guess
      player.alert_invalid_guess if !valid_play?(string)
    end

    @fragments += string

  end

end
