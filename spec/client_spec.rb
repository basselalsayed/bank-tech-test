# frozen_string_literal: true

require 'client'

describe Client do
  let(:account) { instance_double('Account', { balance: 1000,
                                               transactions: [] }) }
  let(:client) { described_class.new(account: account) }

  before do
    allow(account).to receive(:deposit).with(amount: kind_of(Numeric))
    allow(account).to receive(:withdraw).with(amount: kind_of(Numeric))
    # allow(account).to receive(:print_statement).with(no_args)
    client.deposit(amount: 5000)
    client.withdraw(amount: 5000)
    client.print_statement
  end

  describe '#initialization' do
    it 'returns an account' do
      expect(client.account).to eq account
    end
  end

  describe '#deposit' do
    it 'calls deposit method on the account' do
      expect(client.account).to have_received(:deposit).with(amount: 5000)
    end
  end

  describe '#withdraw' do
    it 'calls withdraw method on the account' do
      expect(client.account).to have_received(:withdraw).with(amount: 5000)
    end
  end

  describe '#print_statement' do
    it 'calls upon print_statement method on account' do
      expect(client.account).to have_received(:transactions)
    end
  end
end
