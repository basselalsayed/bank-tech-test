# frozen_string_literal: true

def client_spec_setup
  allow(account_double).to receive(:deposit).with(amount: kind_of(Numeric))
  allow(account_double).to receive(:withdraw).with(amount: kind_of(Numeric))
  allow(printer_double).to receive(:print_statement).with(account_double)
  client.withdraw(amount: account_double.balance)
  client.deposit(amount: 1000)
  client.print_statement
end

def account_spec_setup
  allow(transaction_double).to receive(:new)
    .with(hash_including(type: 'deposit', amount: kind_of(Numeric)))
    .and_return(deposit)
  allow(transaction_double).to receive(:new)
    .with(hash_including(type: 'withdrawal', amount: kind_of(Numeric)))
    .and_return(withdrawal)
  account.withdraw(amount: account.balance)
  account.deposit(amount: 1000)
end

def printer_spec_setup
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
