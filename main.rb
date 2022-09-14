require 'yaml'

module YAML
  class << self
    alias_method :load, :unsafe_load
  end
end

class Words
  attr_accessor :random_word
  attr_accessor :guess_array

  def initialize
    @words = File.open('google-10000-english-no-swears.txt')
    @correct_length_words = Array.new
    self.correct_length_of_words(@correct_length_words, @words)
    @random_word = self.choose_random_word(@correct_length_words)
    @words.close 
  end
  def choose_random_word(words) 
   words.sample.upcase 
  end
  def correct_length_of_words(new_array, word_list)
    word_list.readlines.each do |word|
      if word.length > 5 && word.length < 13
        new_array << word
      end       
    end
  end
end

class Player1
    attr_accessor :player_choice
    def choose_letter_for_guess
        @player_choice = gets.chomp.upcase
        @player_choice
    end
end

class Game
  attr_accessor :guess_array
  attr_accessor :random_word_game_class
  attr_accessor :turns
  attr_accessor :guesses_left
  attr_accessor :guess
  attr_accessor :correct_length_words

  def initialize      
    @p1 = Player1.new
    self.game_loop    
  end
  def game_loop
    @run = true 
    while @run == true
      @W = Words.new
      @random_word_game_class = @W.random_word
      @guess_array = Array.new(@random_word_game_class.length - 1, "_")
      @turns = Array.new();
      @turns[0] = 1
      while @turns[0] < 7
        self.game_round(@guess_array, @random_word_game_class, @turns)
        p @guess_array
      end
      puts @random_word_game_class
      puts "Do you want to play again?"
      puts "Enter Y for yes or N for no"
      @play_again = gets.chomp.upcase
      if @play_again == "N"
        @run = false
      end 
    end
  end
  def check_letter_guess(array, word, guess, turns)
    if word.include? guess
      "Good guess!"
      word.each_char.with_index do |char, index|
        if char == guess
          array[index] = char
        end
      end
    else
      puts "Incorrect Guess!"
      turns[0] = turns[0] + 1;
    end
  end
  def check_win(array, word,turns) 
    correct_letter_count = 0     
    word.each_char.with_index do |char, index|
      if char.to_s == array[index]
        correct_letter_count = correct_letter_count + 1;
      end
    end
    if correct_letter_count == array.length
      puts 'You Win!'
      turns[0] = 7
    else
      puts "Keep Guessing!"
    end
  end
  def ask_to_save
    puts "Do you want to save game?"
    puts "Enter Y for yes or N for no"
    choice = gets.chomp.upcase
    if choice == "Y"
      self.save_game
      puts "Saved!"
    elsif  choice == "N"
      puts "Not Saved!"
    else
      puts "Invalid choice"
      self.ask_to_save
    end
  end
  def ask_to_load
    puts "Do you want to load a previous game?"
    puts "Enter Y for yes or N for no"
    choice = gets.chomp.upcase
    if choice == "Y"
        self.load_game
        puts "Loaded!"
    elsif  choice == "N"
        puts "Continuing with current game"
    else
        puts "Invalid choice"
        self.ask_to_load
    end
  end
  def calculate_guesses_left(turns) 
    @guesses_left = 7 - turns
  end
  def game_round(guess_array, random_word, turns)
    if @turns[0] == 1
      self.ask_to_load
    end
    if @turns[0] > 1
      self.ask_to_save
    end
    puts "You have #{calculate_guesses_left(@turns[0])} guesses left!"
    puts "Enter guess"     
    @guess = @p1.choose_letter_for_guess 
    check_letter_guess(@guess_array, @random_word_game_class, @guess, @turns)
    check_win(@guess_array, @random_word_game_class,@turns)
  end  

  def save_game
    File.open("./hangman.yml", 'w') { |f| YAML.dump([] << self, f) }
  end

  def load_game
    yaml = YAML.load_file("./hangman.yml")
    @random_word_game_class = yaml[0].random_word_game_class
    @guess_array = yaml[0].guess_array
    @turns[0] = yaml[0].turns[0]
    @guesses_left = yaml[0].guesses_left
    @correct_length_words = yaml[0].correct_length_words        
  end
end
new_game = Game.new