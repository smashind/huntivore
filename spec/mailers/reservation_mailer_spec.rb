require 'rails_helper'

RSpec.describe ReservationMailer, type: :mailer do 
	describe 'reservation emails' do 
		let(:user) { FactoryGirl.create(:user) }
		let(:user2) { FactoryGirl.create(:user) }
		let(:property) { FactoryGirl.create(:property, user_id: user.id) }
		let(:reservation) { user2.reservations.create(property_id: property.id, from: "5/15/2020", to: "5/20/2020") }
		let(:user_mail) { ReservationMailer.reservation_email(reservation) }
    
    it 'has the reservation subject' do 
    	expect(user_mail.subject).to eq('Your reservation was successful!')
    end

    it 'has the hunter email' do 
    	expect(user_mail.to).to eq(["#{user2.email}"])
    end

    it 'assigns @first_name' do 
    	expect(user_mail.body).to include(user2.first_name)
    end

    it 'assigns @property.title' do 
    	expect(user_mail.body).to include(property.title)
    end

    it 'assigns @reservation.from' do 
    	expect(user_mail.body).to include(reservation.from)
    end

    let(:owner_email) { ReservationMailer.owner_email(reservation) }

    it 'has the booked subject' do 
    	expect(owner_email.subject).to eq("#{property.title} was booked!")
    end

    it 'has the owner email' do 
    	expect(owner_email.to).to eq(["#{user.email}"])
    end

    it 'has the user information' do 
    	expect(owner_email.body).to include(user2.full_name)
    	expect(owner_email.body).to include(user2.email)
    end

    let(:paid_email) { ReservationMailer.paid_email(reservation) }

    it 'has the payment subject' do
      expect(paid_email.subject).to eq('Reservation Payment Confirmation')
    end

    it 'is sent to the owner' do 
    	expect(paid_email.to).to eq(["#{user.email}"])
    end

    it 'includes the owner earnings' do 
    	expect(paid_email.body).to include(reservation.owner_earnings)
    end

    let(:cancel_email) { ReservationMailer.cancel_email(reservation) }

    it 'is sent to the reservation maker' do 
    	expect(cancel_email.to).to eq(["#{user2.email}"])
    end

    it 'has the cancel subject' do 
    	expect(cancel_email.subject).to eq('Your reservation was canceled')
    end

    it 'assigns reservation maker @first_name' do 
    	expect(cancel_email.body).to include(user2.first_name)
    end

    it 'assigns @cancel_reason' do 
    	reservation.cancel_reason = "I need to cancel this reservation."
    	expect(cancel_email.body).to include("I need to cancel this reservation.")
    end

    let(:paid_night_hunts) { ReservationMailer.paid_night_hunts(Reservation.all) }

    it 'has the subject' do 
    	expect(paid_night_hunts.subject).to eq('Paid night hunts')
    end

    it 'is sent to bossman' do 
    	expect(paid_night_hunts.to).to eq(['danthemanvt@gmail.com'])
    end

    let(:paid_day_hunts) { ReservationMailer.paid_day_hunts(Reservation.all) }

    it 'has the subject' do 
    	expect(paid_day_hunts.subject).to eq('Paid day hunts')
    end

    it 'is sent to bossman' do 
    	expect(paid_day_hunts.to).to eq(['danthemanvt@gmail.com'])
    end

  end
end

