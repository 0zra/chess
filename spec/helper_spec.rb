require 'helper'

describe "Test if our extension to the class Symbol works" do
  it "should return :B" do
    expect(:A.plus).to eq(:B)
  end
  it "should return :H" do
    expect(:G.plus).to eq(:H)
  end
  it "should return :B" do
    expect(:C.minus).to eq(:B)
  end
end
