require 'account'

describe Account do
  let(:account) { described_class.new }

  describe '#initialization' do
    it { expect(account.balance).to be_a_kind_of(Numeric)}
    it { expect(account.transactions).to be_a Array }
  end
  
end