class Client
  attr_reader :account

  def initialize(account)
    @account = account
  end

  def deposit(amount:)
    @account.deposit(amount)
  end

  def withdraw(amount:)
    @account.withdraw(amount)
  end

end