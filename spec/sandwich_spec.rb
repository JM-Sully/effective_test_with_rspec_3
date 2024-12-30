RSpec.describe 'An ideal sandwich' do
  Sandwich = Struct.new(:taste, :toppings)

  it 'is delicious' do
    # arrange: set up an object
    sandwich = Sandwich.new('delicious', [])
    # act: do something with it
    taste = sandwich.taste

    # assert: check that it behaved the way you wanted
    expect(taste).to eq('delicious')
  end

  it 'lets me add toppings' do
    sandwich = Sandwich.new('delicious', [])
    sandwich.toppings << 'red peppers'
    toppings = sandwich.toppings

    # use not_to instead of to 
    expect(toppings).not_to be_empty
  end
end
