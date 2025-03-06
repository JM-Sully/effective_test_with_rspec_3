RSpec.shared_examples 'a URI parser' do |parsing_class|
  it 'parses the host' do
    expect(parsing_class.parse('http://foo.com/').host).to eq 'foo.com'
  end

  it 'parses the port' do
    expect(parsing_class.parse('http://example.com:9876').port).to eq 9876
  end
end
