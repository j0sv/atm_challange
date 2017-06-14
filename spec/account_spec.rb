require './lib/account.rb'


describe Account do

  let(:person) {instance_double('Person', name: 'Thomas')}
  subject { described_class.new({owner: person}) }

  it 'check length of a number' do
    expected_output = subject.pin_code.length
    expect(expected_output).to eq 4
  end

  it '0 balance on initialze on class Accounnt' do
    expected_output = 0
    expect(subject.balance).to eq expected_output
  end

  it 'is expected to have :active status on initialize' do
    expect(subject.account_status).to eq :active
  end

  it 'deactivates account using Instance method' do
    subject.deactivate
    expect(subject.account_status).to eq :deactivated
  end

  it 'is expected to have an owner' do
    expect(subject.owner).to eq person
  end

  it 'is expected to raise error if no owner is set' do
    expect { described_class.new }.to raise_error 'An Account owner is required'
  end

end
