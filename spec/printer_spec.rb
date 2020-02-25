# frozen_string_literal: true

require 'printer'

describe Printer do
  let(:deposit) do
    instance_double('Transaction', :deposit, { type: 'deposit',
                                               amount: 1000,
                                               balance: 1000,
                                               created_at: Time.local(2020, 'feb', 24) })
  end

  # deposit and withdrawal are dummy instances of transaction class
  # that respond to how the Account class creates them
  let(:withdrawal) do
    instance_double('Transaction', :withdrawal, { type: 'withdrawal',
                                                  amount: 500,
                                                  balance: 500,
                                                  created_at: Time.local(2020, 'feb', 25) })
  end
  let(:account) { instance_double('Account', :account, { transactions: [deposit, withdrawal]})}
  
  let(:expected_output) do
    ['date || credit || debit || balance',
     '25/02/2020 || || 500.00 || 500.00',
     '24/02/2020 || 1000.00 || || 1000.00'].join("\n")
  end

  describe '#new_statement' do
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

    it 'prints a complete statement' do
      expect(Printer.print_statement(account: account)).to eq expected_output
    end
  end
end