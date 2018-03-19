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

  context "Testing pawn method for whites" do

    it "should return [C3,C4,C5]" do
      @state[:C][2] = "\u2658"
      @state[:C][4] = "\u2655"
      expect(pawn "B4",@state).to eq (["C4","C5","C3"])
    end
    it "should return []" do
      expect(pawn "H3", @state).to eq([]) #at the time there was no option for black pieces + it is blocked by the G columnt
    end

  end
  context "Testing pawn method for blacks" do
    it "should return F3" do
      expect(pawn "G3", @state).to eq(["F3"])
    end
    it "should be B4 and B6" do
      @state[:C][4] = "\u2659"
      expect(pawn "C5", @state).to eq(["B6","B4"])
    end
    it "should be B3,B4 and B6" do
      @state[:B][4] = nil
      expect(pawn "C5", @state).to eq(["B5","B6","B4"])
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

  context "Testing if is_occupied_by_enemy works as it should" do
    it "should return true" do
      expect(is_occupied_by_enemy? @state[:G][2], "white").to eq(true)
    end
    it "should return false" do
      expect(is_occupied_by_enemy? @state[:G][2], "black").to eq(false)
    end
    it "should return false" do
      expect(is_occupied_by_enemy? @state[:D][5], "black").to eq(false)
    end
  end

  context "Testing knight method" do
    it "should return all 8 options" do
      @state[:C][3] = "\u2658"
#      @state[:D][5] = "\u2655"
      expect(knight("C4", @state)).to eq(["D6","D2","E5","E3","B6","B2","A5","A3"])
    end
    it "should return 4 options" do
      @state[:F][5] = "\u2658"
      expect(knight("F6", @state)).to eq(["E8","E4","D7","D5"])
    end
    it "should return just 1 option" do
      @state[:H][0] = "\u2658"
      expect(knight("H1",@state)).to eq(["F2"])
    end
  end



end
