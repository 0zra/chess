require 'pieces'

describe "Pieces" do

  before(:all) do
    @state = Hash.new(Array.new(8, nil))
    (:A..:H).each do |letter|
      @state[letter] = Array.new(8, nil)
    end
    @state[:H] = ["\u2655","\u2658","\u2657","\u2654","\u2655","\u2657","\u2658","\u2655"]
    @state[:G] = Array.new(8,"\u2659")
    @state[:B] = Array.new(8,"\u265F")
    @state[:A] = ["\u265C","\u265E","\u265D","\u265B","\u265A","\u265D","\u265E","\u265C"]
  end
  it "should return proper piece" do
    expect(piece "\u2657").to eq(["bishop","black"])
    expect(piece "\u265E").to eq(["knight", "white"])
  end

  context "Testing pawn method" do

    it "should return [C3,C4,C5]" do
      @state[:C][3] = "\u2658"
      @state[:C][5] = "\u2655"
      expect(pawn "B4",@state).to eq (["C4","C5","C3"])
    end
    it "should return []" do
      expect(pawn "H3", @state).to eq([])
    end

  end

  context "Testing if coordinats are ok" do
    it "should return true for D4" do
      expect(is_ok? "D4").to eq(true)
    end
    it "should return false for I6" do
      expect(is_ok? "I6").to eq(false)
    end
    it "should return false for B9" do
      expect(is_ok? "B9").to eq(false)
    end
  end
end
