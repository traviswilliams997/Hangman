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

def check_letter_guess(array, word, guess)
    if word.include? guess
        word.each_char.with_index do |char, index|
          if char == guess
            array[index] = char
        end
    end
        else
    end

end
def game_round(guess_array, random_word)
    puts "Enter guess"
    player_choice = gets.chomp
    check_letter_guess(guess_array, random_word, player_choice)
    
    
end
words = File.readlines('google-10000-english-no-swears.txt')
correct_length_words = Array.new
correct_length_of_words(correct_length_words, words)
random_word = choose_random_word(correct_length_words)
 puts random_word 

guess_array = Array.new(random_word.length, "_")
game_round(guess_array, random_word)
p guess_array