require "rails_helper"

RSpec.describe MessageMailer, :type => :mailer do
	let(:user1) { FactoryGirl.create(:user) }
	let(:user2) { FactoryGirl.create(:user) }
	let(:property) { FactoryGirl.create(:property, user: user1 ) }
	let(:message) { user2.sent_messages.create(body: "Hello there", recipient_id: user1.id, property_id: property.id ) }

  describe "New message about a property" do  
  	let(:mail) { MessageMailer.new_message_mail(message)}

  	it 'has the property title in the subject' do 
  		expect(mail.subject).to eq("You have a new message regarding #{property.title}!")
  	end

  	it 'has the recipient email' do 
  		expect(mail.to).to eq(["#{user1.email}"])
  	end

  	it 'assigns the recipient @first_name' do 
  		expect(mail.body.encoded).to include(user1.first_name)
  	end

  	it 'assigns @property.title' do 
  		expect(mail.body.encoded).to include(property.title)
  	end

  	it 'assigns @message.body' do 
  		expect(mail.body.encoded).to include(message.body)
  	end
  end

  let(:outfitter) { FactoryGirl.create(:outfitter, user: user1) }
	let(:outfitter_message) { user2.sent_messages.create(body: "Cool outfitter", recipient_id: user1.id, outfitter_id: outfitter.id )}

  describe "New message about an outfitter" do 
  	let(:mail) { MessageMailer.new_message_mail(outfitter_message) }

  	it 'has the oufitter name in the subject' do 
  		expect(mail.subject).to eq("You have a new message regarding #{outfitter.name}!")
  	end

  	it 'assigns @outfitter.name' do 
  		expect(mail.body.encoded).to include(outfitter.name)
  	end
  end

  describe "Reply" do 
  	let(:reply) { user1.message_replies.create(body: "Oh hi", recipient_id: user2.id, sent_message_id: message.id ) }
    let(:reply_mail) { MessageMailer.reply_message(reply) }

    it 'has the reply subject' do 
    	expect(reply_mail.subject).to eq("#{user1.first_name} replied to your message!")
    end

    it 'has the recipient email' do 
    	expect(reply_mail.to).to eq(["#{user2.email}"])
    end

    it 'assigns the recipient @first_name' do 
    	expect(reply_mail.body.encoded).to include(user2.first_name)
    end

    it 'assigns the @reply.body' do 
    	expect(reply_mail.body.encoded).to include(reply.body)
    end
  end
end
