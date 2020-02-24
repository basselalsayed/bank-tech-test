require 'client'

describe Client do
  let(:account) { double('account', { balance: 1000 }) }
  let(:client) { described_class.new(account) }

  before do
    allow(account).to receive(:deposit).with(kind_of(Numeric))
    allow(account).to receive(:withdraw).with(kind_of(Numeric))
    allow(account).to receive(:print_statement).with(no_args)
  end

  describe '#initialization' do
    it 'returns an account' do
      expect(client.account).to eq account
    end
  end

  describe '#deposit' do
    it 'calls deposit method on the account' do
      client.deposit(amount: 5000)
      expect(client.account).to have_received(:deposit).with(5000)
    end
  end

  describe '#withdraw' do
    it 'calls withdraw method on the account' do
      client.withdraw(amount: 5000)
      expect(client.account).to have_received(:withdraw).with(5000)
    end
  end

  describe '#print_statement' do
    it 'calls upon print_statement method on account' do
      client.print_statement
      expect(client.account).to have_received(:print_statement)
    end
  end
end