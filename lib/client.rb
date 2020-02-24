require_relative 'account'
require_relative 'transaction'
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

  def print_statement
    @account.print_statement
  end
end