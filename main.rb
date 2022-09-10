puts "Hangman!"

def choose_random_word(words) 
   words.sample.upcase
end

def correct_length_of_words(new_array, word_list)
    word_list.each do |word|
        if word.length > 5 && word.length < 13
           new_array << word
        end       
     end
end



def check_letter_guess(array, word, guess, turns)
    if word.include? guess
        word.each_char.with_index do |char, index|
          if char == guess
            array[index] = char
        end
    end
        else
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
    puts "Enter guess"
    player_choice = gets.chomp.upcase
    check_letter_guess(guess_array, random_word, player_choice, turns)
    check_win(guess_array, random_word,turns)

    
    
end
words = File.readlines('google-10000-english-no-swears.txt')
correct_length_words = Array.new
correct_length_of_words(correct_length_words, words)
random_word = choose_random_word(correct_length_words)
 puts random_word 

guess_array = Array.new(random_word.length - 1, "_")

turns = Array.new();
turns[0] = 1

while turns[0] < 7
    game_round(guess_array, random_word, turns)
    p guess_array
end
    