require 'pp'

RSpec.describe Hash, :outer_group do
  it 'is used by RSpec for metadata', :fast do |example|
    sleep 1.0
    # pp example.metadata
    # debugger
  end

  context 'on a nested group' do
    it 'is also inherited' do |example|
      # pp example.metadata
    end
  end
end
