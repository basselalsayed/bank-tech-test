class Account
attr_reader :transactions, :balance

  def initialize
    @transactions = []
    @balance = 0
  end

  def deposit(amount:, transaction: Transaction)
    @balance += amount
    @transactions << transaction.new(type: 'deposit', amount: amount, balance: @balance)
  end

  def withdraw(amount:, transaction: Transaction)
    raise 'Insufficient Funds' if (@balance - amount < 0 )
    @balance -= amount
    @transactions << transaction.new(type: 'withdrawal', amount: amount, balance: @balance)
  end

  def print_statement
    header = ['date || credit || debit || balance']
    arr = @transactions.sort_by(&:created_at).reverse
    header << arr.map { |transaction|
      if transaction.type == 'deposit' 
        transaction = ["#{transaction.created_at.strftime('%d/%m/%Y')}", '||', ('%.2f' % transaction.amount), '||', '||',  ('%.2f' % transaction.balance) ].join(' ')
      else
        transaction = ["#{transaction.created_at.strftime('%d/%m/%Y')}", '||', '||', ('%.2f' % transaction.amount), '||', ('%.2f' % transaction.balance) ].join(' ')
      end
    }.join("\n")
    header.join("\n")
  end
end