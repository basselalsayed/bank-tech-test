# frozen_string_literal: true

require 'simplecov'
require 'simplecov-console'
# require 'client'
require 'helper_methods.rb'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
                                                                 SimpleCov::Formatter::Console,
                                                                 SimpleCov::Formatter::HTMLFormatter
                                                               ])

SimpleCov.start

RSpec.shared_context "Global helpers" do

  # class doubles
  let(:transaction_double) { class_double('Transaction') }
  let(:printer_double) { class_double('Printer') }

  # subjects
  let(:client) { described_class.new(account: account_double, printer: printer_double) }
  let(:account) { described_class.new(transaction: transaction_double) }
  let(:transaction) do
    described_class.new(amount: 200,
                        type: 'deposit',
                        balance: 200,
                        created_at: Time.local(2020, 'feb', 24))
  end
  let(:transaction2) do
    described_class.new(amount: 100,
                        type: 'wtithdrawal',
                        balance: 100,
                        created_at: Time.local(2020, 'feb', 25))
  end

  # instance doubles 
  let(:account_double) { instance_double('Account', :account, { balance: 1000,
    transactions: [deposit, withdrawal] }) }
  let(:deposit) do
    instance_double('Transaction',
                    :deposit, 
                    { type: 'deposit',
                      amount: 1000,
                      balance: 1000,
                      created_at: Time.local(2020, 'feb', 24) 
                    })
  end
  let(:withdrawal) do
    instance_double('Transaction',
                    :withdrawal, 
                    { type: 'withdrawal',
                      amount: 500,
                      balance: 500,
                      created_at: Time.local(2020, 'feb', 25) 
                    })
  end

  # expected outputs
  let(:transaction_expected_output) do
    ['24/02/2020',
     '||',
     '200.00',
     '||',
     '||',
     '200.00'].join(' ')
  end
  let(:transaction2_expected_output) do
    ['25/02/2020',
     '||',
     '||',
     '100.00',
     '||',
     '100.00'].join(' ')
  end
  let(:printer_expected_output) do
    ['date || credit || debit || balance',
     '25/02/2020 || || 500.00 || 500.00',
     '24/02/2020 || 1000.00 || || 1000.00'].join("\n")
  end
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_doubled_constant_names = true
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.include_context "Global helpers"
end

