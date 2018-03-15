class Table
  attr_accessor :state

  def initialize
    @state = Hash.new(Array.new(8, nil))
    (:A..:H).each do |letter|
      @state[letter] = Array.new(8, nil)
    end
    @state[:H] = ["\u2655","\u2658","\u2657","\u2654","\u2655","\u2657","\u2658","\u2655"]
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
    @state[rf.to_sym][cf-1] = nil
  end
end



t = Table.new
t.print_table
print "Koga micemo:"
who = gets.chomp
t.move who, "nesto"
t.print_table
=begin
t.state[:B][0] = nil
gets
t.state[:D][0] = "\u265F"
t.print_table
gets
t.state[:G][1] = nil
t.state[:E][1] = "\u2659"
t.print_table
gets
t.state[:D][0] = nil
t.state[:E][1] = "\u265F"
t.print_table
=end
