# frozen_string_literal: true

require 'transaction'

describe Transaction do
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

  describe '#initialization' do
    it { expect(transaction.amount).to eq 200 }
    it { expect(transaction.type).to eq 'deposit' }
    it { expect(transaction.created_at).to eq '24/02/2020' }
    it { expect(transaction.balance).to eq 200 }
  end

  describe '#print' do
    let(:expected_output) do
      ['24/02/2020',
       '||',
       '200.00',
       '||',
       '||',
       '200.00'].join(' ')
    end
    let(:expected_output2) do
      ['25/02/2020',
       '||',
       '||',
       '100.00',
       '||',
       '100.00'].join(' ')
    end

    it 'returns as a string in the correct format if deposit' do
      expect(transaction.print).to eq expected_output
    end

    it 'returns as a string in the correct format if withdrawal' do
      expect(transaction2.print).to eq expected_output2
    end
  end
end
