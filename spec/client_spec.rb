require 'client'

describe Client do
  let(:account) { double('account', { balance: 1000 }) }
  let(:client) { described_class.new(account) }

  describe '#initialization' do
    it 'returns an array of accounts' do
      expect(client.account).to eq account
    end
  end

  describe '#deposit' do
    it 'adds to the account balance' do
      allow(account).to receive(:deposit).with(kind_of(Numeric))
      client.deposit(amount: 5000)
      expect(client.account).to have_received(:deposit).with(5000)
    end
  end
end