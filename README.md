# words
"Words Test" Programming Challenge by Tom Geer.

## Description

This is an implementation of the challenge published at https://gist.github.com/pedromartinez/7788650.

The implementation was coded against Ruby version 2.3.0, RubyGems version 2.5.1, and bundler version
1.11.2 but may work with earlier versions.

To run the application:

1. Clone this repo onto a system meeting the above requirements
2. `cd` into the root directory of the repo
3. Run `bundle` 
4. Run `ruby words_challenge.rb` and follow instructions
5. Examine the output created in the 'out' subdirectory

## Assumption

There is one assumption in this program worth noting.  The challenge defines sequences as
"sequence of four letters (A-z) that appears in exactly one word of the dictionary."  

We could treat non-letter characters on of two ways:

1.  Any sequence that contains a non-letter is invalid because it is not a sequence of 
    four letters.
    
    i.e. "abcd'efgh" yields only two 4 char sequences ["abcd","efgh"]
         -- "bcd'" and "d'ef"' are invalid because the contain a non-letter
    
2.  Non-letters could be stripped out before slicing sequences
   
    i.e. "abcd'efgh" is altered to "abcdefgh" and yields 
         ["abcd", "bcde", "cdef", "defg", "efgh"]

For this challenge, I chose option #1.