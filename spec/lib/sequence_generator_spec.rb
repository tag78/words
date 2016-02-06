require 'spec_helper'

describe SequenceGenerator do
  
  subject { SequenceGenerator }
  
  it { should respond_to(:parse) }
  
  describe "#parse" do
    
    describe "#interface" do
      
      it "requires two parameters" do
        expect{ subject.parse }.to raise_error(ArgumentError)
        expect{ subject.parse('abc') }.to raise_error(ArgumentError)
        expect{ subject.parse('abc','def','ghi') }.to raise_error(ArgumentError)
      end
      
      it "requires first parameeter to be a string" do
        expect{ subject.parse(1,2) }.to raise_error(Exception).with_message("First parameter must be of type String")
      end
      
      it "requires the second parameter to be an integer" do
        expect{ subject.parse('foo','bar') }.to raise_error(Exception).with_message("Second parameter must be of type Integer")
      end
      
      it "returns an array" do
        expect(subject.parse('abcd', 2)).to be_an(Array)
      end
      
    end
    
    it "returns all sequences of the specified length from the source word" do
      expect(subject.parse('abcd', 2)).to eq(['ab','bc','cd'])
    end
    
    it "does not return sequences that contain non-letters" do
      expect(subject.parse("abc'defg", 3)).to eq(['abc','def','efg'])
    end

    it "returns an empty array when the sequence length is longer than the word" do
      expect(subject.parse('abcde', 10)).to eq([])
    end
      
  end
  
end
