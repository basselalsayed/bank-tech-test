class Transaction
  attr_reader :amount, :type, :balance, :created_at

  def initialize(amount:, type:, balance:, created_at: Time.now.strftime('%d/%m/%Y'))
    @amount = amount
    @type = type
    @balance = balance
    @created_at = created_at
  end
end
