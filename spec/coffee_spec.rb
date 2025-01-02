# this class would typically be in its own file
class Tea
  def ingredients
    @ingredients ||= []
  end

  def add(ingredient)
    ingredients << ingredient
  end

  def price
    1.00
  end
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