require 'yaml'

class Words
    attr_accessor :random_word

    def initialize

        @words = File.open('google-10000-english-no-swears.txt')
        @correct_length_words = Array.new
        self.correct_length_of_words(@correct_length_words, @words)
        @random_word = self.choose_random_word(@correct_length_words)
        @words.close
        
         #puts @random_word 
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
        puts "Enter guess"
        puts "You have six wrong guesses!"
        @player_choice = gets.chomp.upcase
        @player_choice

    end
end

class Game
    def initialize
        
        @W = Words.new
        @p1 = Player1.new
        @guess_array = Array.new(@W.random_word.length - 1, "_")
        @turns = Array.new();
        @turns[0] = 1

        while @turns[0] < 7
            self.game_round(@guess_array, @W.random_word, @turns)
            p @guess_array
            self.save_game
        end
        puts @W.random_word
            
        end
    def check_letter_guess(array, word, guess, turns)
        if word.include? guess
            word.each_char.with_index do |char, index|
              if char == guess
                array[index] = char
            end
        end
            else
                puts "Incorrect Guess"
                turns[0] = turns[0] + 1;
        end
    
    end
    def check_win(array, word,turns) 
        correct_letter_count = 0
    
         
        word.each_char.with_index do |char, index|
            if char.to_s == array[index]
                correct_letter_count = correct_letter_count + 1;
            else
          end
         
    
    end
    if correct_letter_count == array.length
        puts 'You Win!'
        turns[0] = 7
    
      else
        puts "Keep Guessing!"
      end
    end

def game_round(guess_array, random_word, turns)
     @guess = @p1.choose_letter_for_guess
    check_letter_guess(guess_array, random_word, @guess, turns)
    check_win(guess_array, random_word,turns)

end  

def save_game
    File.open("./hangman.yml", 'w') { |f| YAML.dump([] << self, f) }
    
  end

  def load_game
    begin
      yaml = YAML.load_file("./hangman.yml")
       puts yaml[0]
    rescue
      #@history = []
    end
  end
    
end
new_game = Game.new