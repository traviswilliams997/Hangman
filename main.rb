puts "Hangman!"

def choose_random_word(words)
    
   random_word =  words.sample
   random_word
end

def correct_length_of_words(new_array, word_list)
    word_list.each do |word|
        if word.length > 5 && word.length < 13
           new_array << word
        end
       
     end
   
end

words = File.readlines('google-10000-english-no-swears.txt')
correct_length_words = Array.new

correct_length_of_words(correct_length_words, words)
puts choose_random_word(correct_length_words)
  

  



