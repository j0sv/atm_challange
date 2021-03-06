require './lib/atm.rb'
describe Atm do

  let(:account) { instance_double('Account', pin_code: '1234', exp_date: '09/17', account_status: :active) }
  before do
    allow(account).to receive(:balance).and_return(100)
    allow(account).to receive(:balance=)
  end

  it 'has 1000$ on initialize' do
    expected_output = 1000
    expect(subject.funds).to eq expected_output
  end

  it 'funds are reduced at withdraw' do
    expected_output = 950
    subject.withdraw(50, '1234', account)
    expect(subject.funds).to eq expected_output
  end

  it 'allows withdrawal if account has enough balance.' do
    expected_output = { status: true, message: 'success', date: Date.today, amount: 45, bills: [20, 20, 5]}
    expect(subject.withdraw(45, '1234', account)).to eq expected_output
  end

  it 'reject withdraw if ATM has insufficient funds' do
    subject.funds = 50
    expected_output = { status: false, message: 'insufficient funds in ATM', date: Date.today }
    expect(subject.withdraw(100, '1234', account)).to eq expected_output
  end

  it 'reject withdraw if pin is wrong' do
    expected_output = { status: false, message: 'wrong pin', date: Date.today }
    expect(subject.withdraw(50, 9999, account)).to eq expected_output
  end

  it 'reject withdraw if card is expired' do
    allow(account).to receive(:exp_date).and_return('12/15')
    expected_output = { status: false, message: 'card expired', date: Date.today }
    expect(subject.withdraw(6, '1234', account)).to eq expected_output
  end

  it 'reject account if disabled' do
    allow(account).to receive(:account_status).and_return(:disabled)
    expected_output = { status: false, message: 'account disabled', date: Date.today }
    expect(subject.withdraw(100, '1234', account)).to eq expected_output
  end

end
