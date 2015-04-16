require "rails_helper"

RSpec.describe UserMailer, :type => :mailer do
  describe "hunter welcome" do 
  	let(:user) { FactoryGirl.create(:user) } 
  	let(:mail) { UserMailer.welcome_email(user) }

  	it 'has the welcome subject' do 
  		expect(mail.subject).to eq('Welcome to Huntivore!')
  	end

  	it 'has the user email' do 
  		expect(mail.to).to eq([user.email])
  	end

  	it 'is sent from' do 
  		expect(mail.from).to eq(['support@huntivore.com'])
  	end 

  	it 'assigns @first_name' do 
  		expect(mail.body).to include(user.first_name)
  	end
  end

  describe "owner welcome" do 
  	let(:owner) { FactoryGirl.create(:user, owner: true) }
  	let(:owner_mail) { UserMailer.welcome_email_owner(owner) }

  	it 'has the welcome subject' do 
  		expect(owner_mail.subject).to eq('Welcome to Huntivore!')
  	end

  	it 'has the owner email' do 
  		expect(owner_mail.to).to eq([owner.email])
  	end

  	it 'is sent from' do 
  		expect(owner_mail.from).to eq(['support@huntivore.com'])
  	end

  	it 'assigns @first_name' do 
  		expect(owner_mail.body).to include(owner.first_name)
  	end

  	it 'includes call to action' do 
  		expect(owner_mail.body).to include('List it here FREE')
  	end
  end

  describe "new owner notification" do 
  	let(:owner) { FactoryGirl.create(:user, owner: true) }
  	let(:new_owner_mail) { UserMailer.new_owner(owner) }

  	it 'has the subject' do 
  		expect(new_owner_mail.subject).to eq('New owner signup')
  	end

  	it 'has is sent to admin' do 
  		expect(new_owner_mail.to).to eq(['danthemanvt@gmail.com'])
  	end

  	it 'is sent from' do 
  		expect(new_owner_mail.from).to eq(['support@huntivore.com'])
  	end

  	it 'assigns @full_name' do 
  		expect(new_owner_mail.body).to include(owner.full_name)
  	end

  	it 'assigns @email' do 
  		expect(new_owner_mail.body).to include(owner.email)
  	end
  end
end
