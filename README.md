[![Maintainability](https://api.codeclimate.com/v1/badges/c45ee4a4685840d55217/maintainability)](https://codeclimate.com/github/basselalsayed/bank-tech-test/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/c45ee4a4685840d55217/test_coverage)](https://codeclimate.com/github/basselalsayed/bank-tech-test/test_coverage)
[![Build Status](https://travis-ci.org/basselalsayed/bank-tech-test.svg?branch=master)](https://travis-ci.org/basselalsayed/bank-tech-test)

# This will be a simple program for recording a client's bank statement history
# It will consist of 4 classes:
* Client
* Account
* Deposit
* Withdrawal
  
# Classes and Methods
## Client
* account/(s) - a single account or array of accounts
* deposit (creates a new instance of transaction with type: deposit + relevant attributes)
* withdraw (creates a new instance of transaction with type: withdrawal + the relevant attributes)
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

# Setup
## 1. First clone this directory somewhere on your machine
`git clone git@github.com:basselalsayed/bank-tech-test.git`
## 2. Install ruby:
OSX/Linux: 

First install RVM from here:

https://github.com/rvm/ubuntu_rvm

We will be using ruby 2.6.5, after rvm has installed run:

`rvm install 2.6.5`

Windows: 

https://github.com/oneclick/rubyinstaller2/releases/download/RubyInstaller-2.6.5-1/rubyinstaller-devkit-2.6.5-1-x64.exe

Restart your terminal after installing
## 3. Install bundler
- cd into the cloned directory
- run: 
  
  `gem install bundler`

- then:

  `bundle update`
# Usage
- initialize irb and load up the relevent file by running

  `irb`

  `require './lib/client'`
- to create new client and interact with it you can follow the examples below:
    
    `c = Client.new`

    `c.deposit(amount: 100)`
    
    `c.print_statement`
    
    =>

    `"date || credit || debit || balance
    25/02/2020 || 100.00 || || 100.00"`
