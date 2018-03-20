class Table
  attr_accessor :state

  def initialize
    @state = Hash.new(Array.new(8, nil))
    (:A..:H).each do |letter|
      @state[letter] = Array.new(8, nil)
    end
    @state[:H] = ["\u2656","\u2658","\u2657","\u2654","\u2655","\u2657","\u2658","\u2656"]
    @state[:G] = Array.new(8,"\u2659")
    @state[:B] = Array.new(8,"\u265F")
    @state[:A] = ["\u265C","\u265E","\u265D","\u265B","\u265A","\u265D","\u265E","\u265C"]
  end

  def print_table
    @state.reverse_each do |key,value|
      puts "\t\t   + - + - + - + - + - + - + - + - +"
      print "\t\t #{key} |"
      @state[key].each do |position|
        print "   |" if position == nil
        print " #{position} |" if position != nil
      end
      print "\n"
    end
    puts "\t\t   + - + - + - + - + - + - + - + - +"
    puts "\t\t     1   2   3   4   5   6   7   8  "
  end

  def move from, to
    rf = from[0]
    cf = from[1].to_i
    helper = @state[rf.to_sym][cf-1]
    @state[rf.to_sym][cf-1] = nil
    rf = to[0]
    cf = to[1].to_i
    @state[rf.to_sym][cf-1] = helper
  end
end


class String
  def switch
    return "black" if self == "white"
    return "white" if self == "black"
  end
end
