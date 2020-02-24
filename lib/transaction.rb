# frozen_string_literal: true

class Transaction
  attr_reader :amount, :type, :balance, :created_at

  def initialize(amount:, type:, balance:, created_at: Time.now)
    @amount = amount
    @type = type
    @balance = balance
    @created_at = created_at.strftime('%d/%m/%Y')
  end

  def print
    if @type == 'deposit'
      "#{@created_at} || #{format('%.2f', @amount)} || || #{format('%.2f', @balance)}"
    else
      "#{@created_at} || || #{format('%.2f', @amount)} || #{format('%.2f', @balance)}"
    end
  end
end
