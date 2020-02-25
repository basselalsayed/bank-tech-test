# frozen_string_literal: true

require 'client'

describe Client do

  before do
    client_spec_setup
  end
  
  describe '#initialization' do
    it 'returns an account' do
      expect(client.account).to eq account_double
    end
  end

  describe '#deposit' do
    it 'calls deposit method on the account' do
      expect(client.account).to have_received(:deposit).with(amount: 1000)
    end
  end

  describe '#withdraw' do
    it 'calls withdraw method on the account' do
      expect(client.account).to have_received(:withdraw).with(amount: 1000)
    end
  end

  describe '#print_statement' do
    it 'calls upon print_statement method on account' do
      expect(printer_double).to have_received(:print_statement)
    end
  end
end
