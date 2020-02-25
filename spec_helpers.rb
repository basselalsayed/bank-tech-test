lets: 

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
let(:account) do 
  instance_double('Account',
                  :account,
                  { transactions: [deposit, withdrawal]
                  })
end

let(:expected_output) do
  ['date || credit || debit || balance',
   '25/02/2020 || || 500.00 || 500.00',
   '24/02/2020 || 1000.00 || || 1000.00'].join("\n")
end

before do:
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
  allow(account).to receive(:deposit).with(amount: kind_of(Numeric))
  allow(account).to receive(:withdraw).with(amount: kind_of(Numeric))
  account.withdraw(amount: account.balance)
  account.deposit(amount: 1000)