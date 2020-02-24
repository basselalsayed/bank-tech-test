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
    header << sorted_transactions.map do |transaction|
      if transaction.type == 'deposit'
        transaction = [transaction.created_at.strftime('%d/%m/%Y').to_s, '||', ('%.2f' % transaction.amount), '||', '||', ('%.2f' % transaction.balance)].join(' ')
      else
        transaction = [transaction.created_at.strftime('%d/%m/%Y').to_s, '||', '||', ('%.2f' % transaction.amount), '||', ('%.2f' % transaction.balance)].join(' ')
      end
    end.join("\n")
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
