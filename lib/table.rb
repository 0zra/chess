class Table
  attr_accessor :state

  def initialize
    @state = Hash.new(Array.new(8, nil))
    (:A..:H).each do |letter|
      @state[letter] = Array.new(8, 1)
    end

    @state[:B] = Array.new(8,"\u2658")
    @state[:H] = Array.new(8,"\u265F")
  end

  def print_table
    @state.reverse_each do |key,value|
      puts "\t\t   + - + - + - + - + - + - + - + - +"
      puts "\t\t #{key} |   |   |   |   |   |   |   |   |" #if key != :A
    end
    puts "\t\t   + - + - + - + - + - + - + - + - +"
    puts "\t\t     1   2   3   4   5   6   7   8  "
  end

end

t = Table.new
t.print_table
