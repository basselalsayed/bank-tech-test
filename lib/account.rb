class Account
  attr_reader :transactions, :balance

  def initialize(balance: 0, transactions: [], transaction: transaction(transaction))
    @transaction = transaction
    @transactions = transactions
    @balance = balance
  end

  def deposit(amount:)
    add_to_balance(amount)
    @transactions << @transaction.new(type: 'deposit', amount: amount, balance: @balance)
  end

  def withdraw(amount:)
    raise 'Insufficient Funds' if @balance - amount < 0

    take_from_balance(amount)
    @transactions << @transaction.new(type: 'withdrawal', amount: amount, balance: @balance)
  end

  def print_statement
    header = ['date || credit || debit || balance']
    sorted_transactions = @transactions.sort_by(&:created_at).reverse
    sorted_transactions.each { |tran| header << tran.print}
    header.join("\n")
  end

  private

  def transaction(transaction)
    transaction ||= Transaction
  end

  def add_to_balance(amount)
    @balance += amount
  end

  def take_from_balance(amount)
    @balance -= amount
  end
end
