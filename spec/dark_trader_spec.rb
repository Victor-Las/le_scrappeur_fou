require '../lib/dark_trader'

describe "The perform method" do
  it "should return a array made of hash" do
    expect(perform).to be_a(Array)
  end

  it "should include certain crypto-currencies" do
    expect(final_array).to include("BTC")
    expect(final_array).to include("MAID")
    expect(final_array).to include("ZEC")
  end
end

