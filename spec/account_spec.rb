# frozen_string_literal: true

require 'account'
require 'transaction'

describe Account do
  before do
    account_spec_setup
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
      expect(transaction_double).to have_received(:new).with(amount: 1000, balance: 1000, type: 'deposit')
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
      expect(transaction_double)
        .to have_received(:new)
          .with(amount: 500, balance: 500, type: 'withdrawal')
    end

    it 'adds the new instance of withdrawal to transactions' do
      expect(account.transactions.first).to eq withdrawal
    end
  end

end
