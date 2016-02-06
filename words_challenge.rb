#!/usr/bin/env ruby

require 'fileutils'
require './lib/sequence_generator.rb'
require './lib/sequence_store.rb'

store     = SequenceStore.new

File.open("./data/dictionary.txt", "r") do |f|

  # Loop through all words in the file
  f.each_line do |word|

    word.strip!
    
    # Use the generator to get all sequences, then add them to the store
    SequenceGenerator.parse(word, 4).each do |seq|
      store.push seq, word
    end

  end

end

FileUtils.mkdir_p 'out'  # Create output dir if it doesn't exist

# Open both output files for writing
File.open('out/words', 'w') do |words_file|
  File.open('out/sequences', 'w') do |seq_file|
    
    # Loop through unique sequences and write them to output files
    store.unique_sequences.each do |seq_word_pair|
      seq_file.write    seq_word_pair.first + "\n"
      words_file.write  seq_word_pair.last + "\n"
    end
    
  end
end

