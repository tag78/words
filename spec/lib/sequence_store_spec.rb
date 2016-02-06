require 'spec_helper'

describe SequenceStore do
  
  subject { SequenceStore.new }
  
  it { should respond_to(:push) }
  it { should respond_to(:unique_sequences) }
  
  describe "#push" do
    
    describe "#interface" do
      
      it "requires two parameters" do
        expect { subject.push }.to raise_error(ArgumentError)
        expect { subject.push('foo') }.to raise_error(ArgumentError)
        expect { subject.push('a','b','c') }.to raise_error(ArgumentError)
        expect { subject.push('foo','bar').to be_in([true, false]) }
      end
      
      it "requires both parameters to be strings" do
        expect { subject.push('a', 1) }.to raise_error(Exception)
        expect { subject.push(1, 'a') }.to raise_error(Exception)
      end
      
    end

    it "returns true if the sequence did not previously exist in the store" do
      expect(subject.push('foob','foobar')).to be_truthy
      expect(subject.push('lore', 'lorem')).to be_truthy
    end
    
    it "returns false if the sequence previously existed in the store" do
      expect(subject.push('lore', 'lorem')).to be_truthy
      expect(subject.push('lore', 'folklore')).to be_falsey
    end
    
  end
  
  describe "#unique_sequences" do
    
    subject {
      ss = SequenceStore.new
      ss.push('land', 'land')
      ss.push('cape', 'cape') 
      ss.push('lore', 'lorem')
      ss.push('lore', 'folklore')
      ss
    }
    
    it "returns a list of all unique sequences passed to the instance" do
      expect(subject.unique_sequences).to eq([['land', 'land'], ['cape','cape']])
    end

    it "returns an empty array when there are no unique sequences" do
      subject.push('land', 'landscape')
      subject.push('cape', 'landscape')
      expect(subject.unique_sequences).to eq([])
    end
    
  end
  
  # it { should respond_to(:parse) }
  #
  # describe "#parse" do
  #
  #   describe "#interface" do
  #
  #     it "requires two parameters" do
  #       expect{ subject.parse }.to raise_error(ArgumentError)
  #       expect{ subject.parse('abc') }.to raise_error(ArgumentError)
  #       expect{ subject.parse('abc','def','ghi') }.to raise_error(ArgumentError)
  #     end
  #
  #     it "requires first parameeter to be a string" do
  #       expect{ subject.parse(1,2) }.to raise_error(Exception).with_message("First parameter must be of type String")
  #     end
  #
  #     it "requires the second parameter to be an integer" do
  #       expect{ subject.parse('foo','bar') }.to raise_error(Exception).with_message("Second parameter must be of type Integer")
  #     end
  #
  #     it "returns an array" do
  #       expect(subject.parse('abcd', 2)).to be_an(Array)
  #     end
  #
  #   end
  #
  #   it "returns all sequences of the specified length from the source word" do
  #     expect(subject.parse('abcd', 2)).to eq(['ab','bc','cd'])
  #   end
  #
  #   it "does not return sequences that contain non-letters" do
  #     expect(subject.parse("abc'defg", 3)).to eq(['abc','def','efg'])
  #   end
  #
  #   it "returns an empty array when the sequence length is longer than the word" do
  #     expect(subject.parse('abcde', 10)).to eq([])
  #   end
  #
  # end
  
end
