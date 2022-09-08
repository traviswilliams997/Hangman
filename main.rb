puts "Hangman!"
def choose_random_word(word)
   random_word =  word.sample
   check = true
   while check

    if  random_word.length >= 5 && random_word.length <= 12 
        check = false
    else
        choose_random_word(word)
    end
end
    random_word
end
words = File.readlines('google-10000-english-no-swears.txt')
puts choose_random_word(words) 