class Printer
  HEADER = ['date || credit || debit || balance']

  def self.print_statement(account: account)
    new_statement = HEADER.clone
    sorted_transactions = account.transactions.sort_by(&:created_at).reverse
    sorted_transactions.each { |tran| new_statement << tran.print }
    new_statement.join("\n")
  end
end