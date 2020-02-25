# frozen_string_literal: true

require 'printer'

describe Printer do
  describe '#new_statement' do
    before do
      printer_spec_setup
    end

    it 'prints a complete statement' do
      expect(Printer.print_statement(account: account_double)).to eq printer_expected_output
    end
  end
end