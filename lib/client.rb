# frozen_string_literal: true

require_relative 'account'
require_relative 'transaction'
class Client
  attr_reader :account

  def initialize(account: Account.new)
    @account = account
  end

  def deposit(amount:)
    @account.deposit(amount: amount)
  end

  def withdraw(amount:)
    @account.withdraw(amount: amount)
  end

  def print_statement
    Printer.print_statement(account: @account)
  end
end
