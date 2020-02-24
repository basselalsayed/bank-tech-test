class Account
attr_reader :transactions, :balance

  def initialize
    @transactions = []
    @balance = 0
  end

  def deposit(amount:, deposit: Deposit)
    @balance += amount
    @transactions << deposit.new(amount: amount, balance: @balance)
  end

  def withdraw(amount:, withdrawal: Withdrawal)
    raise 'Insufficient Funds' if (@balance - amount < 0 )
    @balance -= amount
    @transactions << withdrawal.new(amount: amount, balance: @balance)
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
    p arr
    p @transactions
    header.join("\n")
  end
end