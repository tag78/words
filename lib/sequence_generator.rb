class SequenceGenerator
  
  def self.parse(word, sequence_length)
    
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