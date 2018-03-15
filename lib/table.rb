class Table
  attr_accessor :state

  def initialize
    @state = Hash.new(Array.new(8, nil))
    (:A..:H).each do |letter|
      @state[letter] = Array.new(8, nil)
    end

    @state[:B] = Array.new(8,"\u265F")
    @state[:G] = Array.new(8,"\u2659")
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

end

t = Table.new
t.print_table
