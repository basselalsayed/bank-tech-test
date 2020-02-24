require 'account'

describe Account do
  let(:account) { described_class.new }
  let(:deposit) { double(:deposit) }
  let(:transaction) { double(:deposit, { type: 'deposit', amount: 1000, balance: 1000,  created_at: Time.local(2020, 'feb', 24) }) }
  
  let(:withdrawal) { double(:withdrawal) }
  let(:transaction2) { double(:withdrawal, { type: 'withdrawal', amount: 500, balance: 500, created_at: Time.local(2020, 'feb', 25) }) }
  
  before do
    allow(deposit).to receive(:new).with(any_args).and_return(transaction)
    allow(withdrawal).to receive(:new).with(any_args).and_return(transaction2)
  end

  describe '#initialization' do
    it { expect(account.balance).to be_a_kind_of(Numeric)}
    it { expect(account.transactions).to be_a Array }
  end

  describe '#deposit' do
    it 'creates a new instance of deposit' do
      expect(deposit).to receive(:new).with(amount: 1000, balance: 1000)
      account.deposit(amount: 1000, deposit: deposit)
    end

    context 'deposits before each test' do
      before do
        account.deposit(amount: 1000, deposit: deposit)
      end

      it 'adds the new instance of deposit to transactions' do
        expect(account.transactions.first).to eq transaction
      end
      it 'increases the balance' do
        expect(account.balance).to eq 1000
      end
    end
  end

  describe '#withdraw' do
    it 'raises an error when attempting to withdraw more than balance' do
      expect { account.withdraw(amount: 500, withdrawal: withdrawal) }
             .to raise_error(RuntimeError, "Insufficient Funds")
    end

    context 'withdrawal needs initial balance to be greater than 0' do
      before do
        account.deposit(amount: 1000, deposit: deposit)
      end

        it 'creates a new instance of withdrawal' do
          expect(withdrawal).to receive(:new).with(amount: 500, balance: 500)
          account.withdraw(amount: 500, withdrawal: withdrawal)
        end

      describe '#withdraw' do
        before do
          account.withdraw(amount: 500, withdrawal: withdrawal)
        end

        it 'adds the new instance of withdrawal to transactions' do
          expect(account.transactions.last).to eq transaction2
        end
        it 'decreases the balance' do
          expect(account.balance).to eq 500
        end
      end
    end
  end

  describe 'needs historic transactions to test print_statement' do
    let(:expected_output) { ['date || credit || debit || balance',
                             '25/02/2020 || || 500.00 || 500.00',
                             '24/02/2020 || 1000.00 || || 1000.00'].join("\n") }
    before do 
      account.deposit(amount: 1000, deposit: deposit)
      account.withdraw(amount: 500, withdrawal: withdrawal)
    end
    it 'returns a string of all previous transactions' do
      expect(account.print_statement).to eq expected_output
    end
  end
  
end