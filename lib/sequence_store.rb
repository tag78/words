class SequenceStore

  def initialize
    @store = Hash.new
    @seq_pairs = []
  end
  
  def push(sequence, source_word)

    raise Exception.new "Parameters must be a strings" unless sequence.is_a?(String) \
      && source_word.is_a?(String)

    # Fetch the leaf node and it's parent node for the current sequence
    leaf, parent = leaf_and_parent_nodes_for sequence

    if leaf.is_a?(Hash) && leaf.empty?
      # if the leaf node is an empty hash, this is the first time we've seen this sequence
      #   therefore, store the source word
      parent.store(sequence.chars.last, source_word)
    else
      # if the leaf node is not an empty hash, this is a duplicate sequence
      #   therefore, set the value to nil
      parent.store(sequence.chars.last, nil)
    end
  end
  
  def unique_sequences
    @seq_pairs.clear
    parse_node @store 
    @seq_pairs
  end
  
  private
  
  def leaf_and_parent_nodes_for(sequence)
    # Initialize vars to hold current node and it's parent as we descend down the tree
    cur_node = @store
    parent = nil

    # Iterate over characters in the sequence, advancing down the tree store in the @store
    sequence.chars.each do |char|
      begin
        # set the parent to th current_node and advance current_node one position down the tree
        parent = cur_node                 
        cur_node = cur_node.fetch(char)
      rescue KeyError
        # if key didn't exist, initialize it to an empty hash before moving on
        #   (this just indicates it's the first time we've encoutered this sequence)
        cur_node.store(char, {})
        cur_node = cur_node.fetch(char)
      end
    end
    
    return cur_node, parent
  end

  def parse_node(node, path = "")
    # Recursively traverse the tree for non-nil leaf nodes
    if node.is_a?(Hash)
      node.keys.each do |key|
        parse_node(node[key], path + key)
      end
    else
      # When we find a leaf, add it to the unique list if it is not nil
      #   (nil indicates the sequence was not unique)
      @seq_pairs.push([path, node]) unless node.nil?
    end
  end
  
end