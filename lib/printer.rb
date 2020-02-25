# frozen_string_literal: true

class Printer
  HEADER = ['date || credit || debit || balance'].freeze

  def self.print_statement(account)
    new_statement = HEADER.dup
    sorted_transactions = account.transactions.sort_by(&:created_at).reverse
    sorted_transactions.each { |tran| new_statement << tran.print }
    new_statement.join("\n")
  end
end
