require 'client'

describe Client do
  let(:account) { double('account', { balance: 1000 }) }
  let(:client) { described_class.new(account) }

  before do
    allow(account).to receive(:deposit).with(kind_of(Numeric))
    allow(account).to receive(:withdraw).with(kind_of(Numeric))
  end

  describe '#initialization' do
    it 'returns an array of accounts' do
      expect(client.account).to eq account
    end
  end

  describe '#deposit' do
    it 'adds to the account balance' do
      client.deposit(amount: 5000)
      expect(client.account).to have_received(:deposit).with(5000)
    end
  end

  describe '#withdraw' do
    it 'adds to the account balance' do
      client.withdraw(amount: 5000)
      expect(client.account).to have_received(:withdraw).with(5000)
    end
  end
end