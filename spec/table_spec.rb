require 'table'

describe Table do
  before(:each) do
    @table = Table.new
  end
  it "should have state attribute" do
    expect(@table).to respond_to(:state)
  end
  it "should have entire B and G row filled with pawns" do
    expect(@table.state[:B]).to eq(Array.new(8,"\u265F"))
    expect(@table.state[:G]).to eq(["\u2659","\u2659","\u2659","\u2659","\u2659","\u2659","\u2659","\u2659"])

  end
end
