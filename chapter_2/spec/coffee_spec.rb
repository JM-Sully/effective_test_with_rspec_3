# this class would typically be in its own file
class Tea
  BASE_PRICE = 1.00
  OAT_MILK_PRICE = 0.25

  def ingredients
    @ingredients ||= []
  end

  def add(ingredient)
    ingredients << ingredient
  end

  def price
    ingredients.include?(:oat_milk) ? BASE_PRICE + OAT_MILK_PRICE : BASE_PRICE
  end
end

RSpec.configure do |config|
  # the file where RSpec will store information about which examples are failing,
  # or other returned based on other runtime options, so that it knows what to rerun
  config.example_status_persistence_file_path = 'spec/examples.txt'
end

RSpec.describe 'A cup of tea' do
  let(:tea) { Tea.new }

  it 'costs $1' do
    expect(tea.price).to eq(1.00)
  end

  # use context to group together a set of examples and their setup code 
  context 'with oat milk' do
    before { tea.add :oat_milk }
    
    it 'costs $1.25' do
      expect(tea.price).to eq(1.25)
    end
  end
end
