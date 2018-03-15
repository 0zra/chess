require 'table'

describe Table do
  before(:each) do
    @table = Table.new
  end
  it "should have state attribute" do
    expect(@table).to respond_to(:state)
  end
  it "should have entire B and H row filled with pawns" do
    expect(@table.state[:B]).to eq(["\u2658","\u2658","\u2658","\u2658","\u2658","\u2658","\u2658","\u2658"])
    expect(@table.state[:H]).to eq(Array.new(8,"\u265F")
    )
  end
end
