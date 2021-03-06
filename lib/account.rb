# frozen_string_literal: true

class Account
  attr_reader :transactions, :balance

  def initialize(balance: 0, transactions: [], transaction: transaction(transaction))
    @balance = balance
    @transaction = transaction
    @transactions = transactions
  end

  def deposit(amount:)
    add_to_balance(amount)
    @transactions << @transaction.new(type: 'deposit', amount: amount, balance: @balance)
  end

  def withdraw(amount:)
    raise 'Insufficient Funds' unless take_from_balance(amount)

    @transactions << @transaction.new(type: 'withdrawal', amount: amount, balance: @balance)
  end

  private

  def transaction(transaction)
    transaction || Transaction
  end

  def add_to_balance(amount)
    @balance += amount
  end

  def take_from_balance(amount)
    @balance < amount ? false : (@balance -= amount)
  end
end
