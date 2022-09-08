puts "Hangman!"

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
puts correct_length_words.length

  

  
# puts choose_random_word(words) 



# def choose_random_word(word)
#     begin
#    random_word =  word.sample
#    check = true
#    while check

#     if  random_word.length >= 5 && random_word.length <= 12 
#         check = false
#     else
#         count = count + 1
#         if count > 1000
#             exit 
#         end
#         choose_random_word(word)
        
        
#     end
# end
# rescue
#     choose_random_word(word)
# end
#     random_word
# end