require "./lib/account.rb"
require "./lib/atm.rb"

class Person
    attr_accessor :name, :cash, :account

    def initialize(args={})
        args[:name] == nil ? missing_name : @name=args[:name]
        @cash=0
    end



    def create_account
       @account = Account.new({owner: self})
    end

    def deposit(amount)
        if @cash>=amount
            account==nil ? missing_account : account.balance+=amount
            @cash -=amount
        else
            missing_cash
        end
    end

    def withdraw(args = {})
        @account == nil ? missing_account : withdraw_funds(args)
    end

    private

  def withdraw_funds(args)
    args[:atm] == nil ? missing_atm : atm = args[:atm]
    account = @account
    amount = args[:amount]
    pin = args[:pin]
    response = atm.withdraw(amount, pin, account)
    if response[:status]
      increase_cash(response)
    else
      response
    end
  end

  def missing_atm
    raise 'An ATM is required'
  end

  def missing_name
    raise 'A name is required'
  end

  def missing_account
    raise 'No account present'
  end

  def missing_cash
    raise 'Person don\'t have enough cash'
  end

  def increase_cash(response)
    @cash += response[:amount]
  end

end
