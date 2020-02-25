# frozen_string_literal: true

require_relative 'account'
require_relative 'transaction'
require_relative 'printer'
class Client
  attr_reader :account

  def initialize(account: Account.new, printer: Printer)
    @account = account
    @printer = printer
  end

  def deposit(amount:)
    @account.deposit(amount: amount)
  end

  def withdraw(amount:)
    @account.withdraw(amount: amount)
  end

  def print_statement
    @printer.print_statement(@account)
  end
end
