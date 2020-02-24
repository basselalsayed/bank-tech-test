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
end