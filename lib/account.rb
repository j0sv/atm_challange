require 'date'

class Account
  STANDARD_VALIDITY_YRS = 5
  attr_accessor :pin_code, :exp_date, :account_status, :balance, :owner

  def initialize (obj)
    @account_status = :active
    @pin_code=genarate_pin()
    @exp_date=set_expire_date
    @balance=0
    set_owner(obj)
  end

  public

  def deactivate
    @account_status = :deactivated
  end

  public
  def genarate_pin()
    tmp_pin = rand(0000..9999).to_s
    while tmp_pin.length < 4
        tmp_pin="0"+tmp_pin
    end
    tmp_pin
  end

  def set_expire_date
    Date.today.next_year(STANDARD_VALIDITY_YRS).strftime('%m/%Y')
  end

  private

  def set_owner(obj)
    obj == nil ?  missing_owner : @owner = obj
  end

  def missing_owner
    raise "An Account owner is required"
  end

  def deposit(amount)
    @balance+=amount
  end
  
  def set_balance (amount)
    @balance=amount
  end
  



end
