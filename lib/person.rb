require "./lib/account.rb"
require "./lib/atm.rb"

class Person
    attr_accessor :name, :cash, :account
    
    def initialize(args={})
        args[:name] == nil ? missing_name : @name=args[:name]
        @cash=0
    end
    
    def missing_name 
        raise 'A name is required'
    end
    
    def missing_account
       raise 'No account present' 
    end
    
    def create_account
       @account = Account.new(self) 
    end
    
    def deposit(amount)
        account==nil ? missing_account : account.balance+=amount
    end
    
end
