# frozen_string_literal: true

require 'account'
require 'transaction'

describe Account do
  let(:account) { described_class.new(transaction: transaction) }
  let(:transaction) { class_double('Transaction') }
  let(:deposit) do
    instance_double('Transaction', :deposit, { type: 'deposit',
                                               amount: 1000,
                                               balance: 1000,
                                               created_at: Time.local(2020, 'feb', 24) })
  end

  # deposit and withdrawal are dummy instances of transaction class
  # that respond to how the Account class creates them
  let(:withdrawal) do
    instance_double('Transaction', :withdrawal, { type: 'withdrawal',``
                                                  amount: 500,
                                                  balance: 500,
                                                  created_at: Time.local(2020, 'feb', 25) })
  end

  before do
    allow(transaction).to receive(:new).with(hash_including(type: 'deposit')).and_return(deposit)
    allow(transaction).to receive(:new).with(hash_including(type: 'withdrawal')).and_return(withdrawal)
    account.withdraw(amount: account.balance)
    account.deposit(amount: 1000)
  end

  describe '#initialization' do
    it { expect(account.balance).to be_a_kind_of(Numeric) }
    it { expect(account.transactions).to be_a Array }
  end

  describe '#deposit' do
    it 'increases the balance' do
      expect(account.balance).to eq 1000
    end

    it 'creates a new instance of transaction' do
      expect(transaction).to have_received(:new).with(amount: 1000, balance: 1000, type: 'deposit')
    end

    it 'adds the new instance of deposit to transactions' do
      expect(account.transactions.last).to eq deposit
    end
  end

  describe '#withdraw' do
    it 'decreases the balance' do
      expect(account.balance).to eq 1000
    end

    it 'raises an error when attempting to withdraw more than balance' do
      expect { account.withdraw(amount: 1000.01) }
        .to raise_error(RuntimeError, 'Insufficient Funds')
    end

    it 'creates a new instance of withdrawal with desired attributes' do
      account.withdraw(amount: 500)
      expect(transaction).to have_received(:new).with(amount: 500, balance: 500, type: 'withdrawal')
    end

    it 'adds the new instance of withdrawal to transactions' do
      expect(account.transactions.first).to eq withdrawal
    end
  end

  describe 'needs historic transactions to test print_statement' do
    let(:expected_output) do
      ['date || credit || debit || balance',
       '25/02/2020 || || 500.00 || 500.00',
       '24/02/2020 || 1000.00 || || 1000.00'].join("\n")
    end

    before do
      allow(deposit).to receive(:print).and_return(['24/02/2020',
                                                    '||',
                                                    '1000.00',
                                                    '||',
                                                    '||',
                                                    '1000.00'].join(' '))
      allow(withdrawal).to receive(:print).and_return(['25/02/2020',
                                                       '||',
                                                       '||',
                                                       '500.00',
                                                       '||',
                                                       '500.00'].join(' '))
    end

    it 'returns a string of all previous transactions' do
      expect(account.print_statement).to eq expected_output
    end
  end
end
