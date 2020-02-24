require 'account'

describe Account do
  let(:account) { described_class.new }
  let(:deposit) { double(:deposit, { created_at: Time.now }) }
  let(:withdrawal) { double(:withdrawal, { created_at: Time.now }) }
  
  before do
    allow(deposit).to receive(:new).with(hash)
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

end