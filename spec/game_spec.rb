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
    it "should return 6th row" do
      expect(domain_of "black",@state).to eq(["F1","F2","F3","F4","F5","F6","F7","F8"])
    end
    it "should retrn 6th row plus 8 options" do
      @state[:C][4]= "\u2658"
      expect(domain_of("black",@state).length).to eq(16)
    end
  end
end

describe Player do
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
  context "testing the is_in_check? method" do
    it "should return false" do
      player = Player.new "black"
      expect(player.is_in_check? @state).to eq(false)
    end
    it "should return false" do
      player = Player.new "black"
      @state[:G][2] = nil
      @state[:E][0] = "\u265D"
      expect(player.is_in_check? @state).to eq(true)
    end
  end
end
