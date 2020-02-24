# frozen_string_literal: true

require 'client'

describe Client do
  let(:client) { described_class.new }

  describe '#initialization' do
    it { expect(client.account.balance).to eq 0 }
  end

  describe 'deposits and withdraws' do
    before do
      client.deposit(amount: 100)
    end

    it 'deposits and logs a transaction' do
      expect(client.account.balance).to eq 100
    end

    it 'logs a deposit transaction' do
      expect(client.account.transactions.first.type).to eq 'deposit'
    end

    it 'withdraws from account' do
      client.withdraw(amount: 50)
      expect(client.account.balance).to eq 50
    end

    it 'logs a withdraw transaction' do
      client.withdraw(amount: 50)
      expect(client.account.transactions.last.type).to eq 'withdrawal'
    end

    it 'prints a statement' do
      expect(client.print_statement).to eq [
        'date || credit || debit || balance',
        '24/02/2020 || 100.00 || || 100.00'
      ].join("\n")
    end
  end
end
