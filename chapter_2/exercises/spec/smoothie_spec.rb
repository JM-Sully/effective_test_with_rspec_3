class Smoothie
  def flavour
    :raspberry
  end
end

RSpec.configure do |config|
  config.example_status_persistence_file_path = 'spec/examples.txt'
end

RSpec.describe Smoothie do
  let(:smoothie) { Smoothie.new }

  it 'tastes like raspberry' do
    expect(smoothie.flavour).to be :raspberry
  end

  it 'is cold' do
    expect(smoothie.temperature).to be < 5.0
  end
end
