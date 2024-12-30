RSpec.describe 'An ideal sandwich' do
  Sandwich = Struct.new(:taste, :toppings)

  # RSpec before hook, will run automatically before each example
  before { @sandwich = Sandwich.new('delicious', []) }

  it 'is delicious' do
    taste = @sandwich.taste

    expect(taste).to eq('delicious')
  end

  it 'lets me add toppings' do
    @sandwich.toppings << 'red peppers'
    toppings = @sandwich.toppings

    expect(toppings).not_to be_empty
  end
end
