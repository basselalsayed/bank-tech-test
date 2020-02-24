require 'transaction'

describe Transaction do
  let(:transaction) { described_class.new(amount: 200, type: 'deposit', balance: 200) }

  describe '#initialization' do
    it { expect(transaction.amount).to eq 200 }
    it { expect(transaction.type).to eq 'deposit' }
    it { expect(transaction.created_at).to eq '24/02/2020' }
    it { expect(transaction.balance).to eq 200 }
  end
end
