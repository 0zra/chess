require 'game'

describe "the game" do

  before(:each) do
    @state = Hash.new(Array.new(8, nil))
    (:A..:H).each do |letter|
      @state[letter] = Array.new(8, nil)
    end
    @state[:H] = ["\u2655","\u2658","\u2657","\u2654","\u2655","\u2657","\u2658","\u2655"]
    @state[:G] = Array.new(8,"\u2659")
    @state[:B] = Array.new(8,"\u265F")
    @state[:A] = ["\u265C","\u265E","\u265D","\u265B","\u265A","\u265D","\u265E","\u265C"]
  end
  context "testing the domain_of function" do
    it "lets see what'll come out XD" do
      expect(domain_of "black",@state).to eq(["F1","F2","F3","F4","F5","F6","F7","F8"])
    end
  end
end
