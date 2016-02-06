# Parses out all letter sequnces of a consumer-specified length from a source word.
#
# == Example Usage
#
# SequenceGenerator.parse("abcd", 2) will return [['ab','abcd'],['bc','abcd'],['cd','abcd']]
#
# == Treatment of non-letters
#
# This class treats non letters (anything not A-Z or a-z) as characters that invalidate
#   a sequence. It does <b>not</b> strip them out and return sequences that would exist
#   if the character were not present.
#
#   Example: SequenceGenerator.parse("it's", 2) will return [["it", "it's"]] 
#     ** the sequences "t'" and "'s" are not valid 
#     ** the "'" is not stripped out to make "ts" a valid sequence
class SequenceGenerator
  
  def self.parse(word, sequence_length)
    
    # Validate parameters
    raise Exception.new "First parameter must be of type String" unless word.is_a?(String)
    raise Exception.new "Second parameter must be of type Integer" unless sequence_length.is_a?(Integer)

    # Return if stripped length isn't long enough to satisfy sequence length
    return [] if word.length < sequence_length

    # Instantiate array to hold substrings that will be returned
    sequences = []

    (0..(word.length - sequence_length)).each do |i|

      # grab a substring of length seq_length
      s = word[i, sequence_length]

      # Add the sequence to the return list if it contains only letters
      #   (see assumption in README.md about the "sequence of letters requirement")
      sequences.push(s) if s.match(/[^A-Z^a-z]/).nil?

    end

    sequences

  end
  
end