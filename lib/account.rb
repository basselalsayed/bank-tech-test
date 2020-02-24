class Account
attr_reader :transactions, :balance

  def initialize
    @transactions = []
    @balance = 0
  end

  def deposit(amount:, deposit: Deposit)
    @balance += amount
    deposit.new(amount: amount, balance: @balance)
  end
end