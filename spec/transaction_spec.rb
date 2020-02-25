# frozen_string_literal: true

require 'transaction'

describe Transaction do
  describe '#initialization' do
    it { expect(transaction.amount).to eq 200 }
    it { expect(transaction.type).to eq 'deposit' }
    it { expect(transaction.created_at).to eq '24/02/2020' }
    it { expect(transaction.balance).to eq 200 }
  end

  describe '#print' do
    it 'returns as a string in the correct format if deposit' do
      expect(transaction.print).to eq transaction_expected_output
    end

    it 'returns as a string in the correct format if withdrawal' do
      expect(transaction2.print).to eq transaction2_expected_output
    end
  end
end
