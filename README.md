# This will be a simple program for recording a client's bank statement history
# It will consist of 4 classes:
* Client
* Account
* Deposit
* Withdrawal
  
# Classes and Methods
## Client
* account/(s) - a single account or array of accounts
* deposit (creates a new instance of Deposit with the relevant attributes)
* withdraw (creates a new instance of Withdrawl with the relevant attributes)
* print_statement (calls upon account.statement instance method)

# Account
* transactions (array or hash containing instances of deposit & withdraw)
* statement (returns array or sorted string of all transactions)

# Deposit and Withdrawal
* Will only have initialize methods with attributes of:
  * amount
  * created_at (with defaults of `Time.now`)
  * account_balance_after_transaction

Since there is no database with unique keys attached to the models we will simply pass in an instance of account to client for testing.

## Changelog v1.1
* Classes changed to have one transaction class with a `type` attribute equalling either deposit or withdrawal
 