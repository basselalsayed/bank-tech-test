require 'client'

describe Client do
  let(:client) { described_class.new }

  describe '#initialization' do
    it 'returns an array of accounts' do
      expect(client.accounts).to be_a Array
    end
  end
end