require 'account'

describe Account do
  let(:account) { described_class.new }
  let(:deposit) { double(:deposit, { created_at: Time.now }) }
  let(:deposit2) { double(:deposit, { amount: 1000, balance: 1000, created_at: Time.now }) }
  let(:withdrawal) { double(:withdrawal, { created_at: Time.now }) }
  let(:withdrawal2) { double(:withdrawal, { amount: 500, balance: 500, created_at: Time.now }) }
  
  before do
    allow(deposit).to receive(:new).with(any_args).and_return(deposit2)
    allow(withdrawal).to receive(:new).with(any_args).and_return(withdrawal2)
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
  end
  describe '#deposit' do
    before do
      account.deposit(amount: 1000, deposit: deposit)
    end
    
    it 'adds the new instance of deposit to transactions' do
      expect(account.transactions.first).to eq deposit2
    end
    it 'increases the balance' do
      expect(account.balance).to eq 1000
    end
  end

  context 'withdrawal needs initial balance to be greater than 0' do
    before do
      account.deposit(amount: 1000, deposit: deposit)
    end

    describe '#withdraw' do
      it 'creates a new instance of withdrawal' do
        expect(withdrawal).to receive(:new).with(amount: 500, balance: 500)
        account.withdraw(amount: 500, withdrawal: withdrawal)
      end
    end

    describe '#withdraw' do
      before do
        account.withdraw(amount: 500, withdrawal: withdrawal)
      end
      
      it 'adds the new instance of withdrawal to transactions' do
        expect(account.transactions.last).to eq withdrawal2
      end
      it 'decreases the balance' do
        expect(account.balance).to eq 500
      end
    end
  end
end