require 'date'

class Atm
attr_accessor :funds

def initialize
  @funds = 1000
end

def withdraw(amount, pin_code, account)
  case
  when card_expired?(account.exp_date)
    { status: false, message: 'card expired', date: Date.today }
  when incorrect_pin?(pin_code, account.pin_code)
    return { status: false, message: 'wrong pin', date: Date.today }
  when insufficient_funds_in_account?(amount, account.balance)
    return { status: false, message: 'insufficient funds', date: Date.today }
  when insufficient_funds_in_atm?(amount, @funds)
    return { status: false, message: 'insufficient funds in ATM', date: Date.today }
  else
    if account_disabled?(account.account_status)
      return { status: false, message: 'account disabled', date: Date.today }
    else
      perform_transaction(amount, account.balance)
      return { status: true, message: 'success', date: Date.today, amount: amount, bills: bills(amount) }
            #  { status: true, message: 'success', date: Date.today, amount: amount, bills: add_bills(amount) }
    end
  end
end


public

def bills(amount)
  denominations = [20, 10, 5]
  bills = []
  denominations.each do |bill|
      while amount - bill >= 0
        amount -= bill
        bills << bill
      end
      bills
  end
  bills
end

def insufficient_funds_in_account?(amount, account)
  return amount > account
end

def insufficient_funds_in_atm?(amount, funds)
  return amount > funds
end

def perform_transaction(amount, account)
  @funds-=amount
end

def incorrect_pin?(entered_pin_code, account_pin_code)
  return entered_pin_code != account_pin_code
end

def account_disabled?(status)
  return status != :active
end

def card_expired?(datum)
  return Date.strptime(datum, '%m/%y') < Date.today
end

end
