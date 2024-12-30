RSpec.describe 'An ideal sandwich' do
  Sandwich = Struct.new(:taste, :toppings)

  # use a helper method, with memoization to create a new sandwich instance
  def sandwich
    @sandwich ||= Sandwich.new('delicious', [])
  end

  it 'is delicious' do
    taste = sandwich.taste

    expect(taste).to eq('delicious')
  end

  it 'lets me add toppings' do
    sandwich.toppings << 'red peppers'
    toppings = sandwich.toppings

    expect(toppings).not_to be_empty
  end
end
