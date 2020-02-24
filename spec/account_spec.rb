require 'account'

describe Account do
  let(:account) { described_class.new(transaction: transaction) }
  let(:transaction) { double(:transaction) }

  # deposit and withdrawal are dummy instances of transaction class that respond
  # to how the Account class creates them
  let(:deposit) { double(:deposit, { type: 'deposit', amount: 1000, balance: 1000, created_at: Time.local(2020, 'feb', 24) }) }
  let(:withdrawal) { double(:withdrawal, { type: 'withdrawal', amount: 500, balance: 500, created_at: Time.local(2020, 'feb', 25) }) }

  before do
    allow(transaction).to receive(:new).with(hash_including(type: 'deposit')).and_return(deposit)
    allow(transaction).to receive(:new).with(hash_including(type: 'withdrawal')).and_return(withdrawal)
  end

  describe '#initialization' do
    it { expect(account.balance).to be_a_kind_of(Numeric) }
    it { expect(account.transactions).to be_a Array }
  end

  describe '#deposit' do
    it 'creates a new instance of deposit' do
      expect(transaction).to receive(:new).with(amount: 1000, balance: 1000, type: 'deposit')
      account.deposit(amount: 1000)
    end

    context 'deposits before each test' do
      before do
        account.deposit(amount: 1000)
      end

      it 'adds the new instance of deposit to transactions' do
        expect(account.transactions.first).to eq deposit
      end
      it 'increases the balance' do
        expect(account.balance).to eq 1000
      end
    end
  end

  describe '#withdraw' do
    it 'raises an error when attempting to withdraw more than balance' do
      expect { account.withdraw(amount: 500) }
        .to raise_error(RuntimeError, 'Insufficient Funds')
    end

    context 'withdrawal needs initial balance to be greater than 0' do
      before do
        account.deposit(amount: 1000)
      end

      it 'creates a new instance of withdrawal' do
        expect(transaction).to receive(:new).with(amount: 500, balance: 500, type: 'withdrawal')
        account.withdraw(amount: 500)
      end

      describe '#withdraw' do
        before do
          account.withdraw(amount: 500)
        end

        it 'adds the new instance of withdrawal to transactions' do
          expect(account.transactions.last).to eq withdrawal
        end
        it 'decreases the balance' do
          expect(account.balance).to eq 500
        end
      end
    end
  end

  describe 'needs historic transactions to test print_statement' do
    let(:expected_output) do
      ['date || credit || debit || balance',
       '25/02/2020 || || 500.00 || 500.00',
       '24/02/2020 || 1000.00 || || 1000.00'].join("\n")
    end
    before do
      account.deposit(amount: 1000)
      account.withdraw(amount: 500)
    end
    it 'returns a string of all previous transactions' do
      expect(account.print_statement).to eq expected_output
    end
  end
end
