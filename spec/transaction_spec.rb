require 'transaction'

describe Transaction do
  let(:transaction) { described_class.new(amount: 200, type: 'deposit', balance: 200, created_at: Time.local(2020, 'feb', 24)) }

  describe '#initialization' do
    it { expect(transaction.amount).to eq 200 }
    it { expect(transaction.type).to eq 'deposit' }
    it { expect(transaction.created_at).to eq '24/02/2020' }
    it { expect(transaction.balance).to eq 200 }
  end

  describe '#print' do
    let(:expected_output) { ['24/02/2020',
                             '||',
                             '200.00',
                             '||',
                             '||',
                             '200.00'].join(' ') }
    it 'returns as a string in the correct format' do
      expect(transaction.print).to eq expected_output
    end
  end
end
