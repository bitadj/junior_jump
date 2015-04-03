FactoryGirl.define do
	factory :contact do
		firstname { Faker::Name.first_name}
		lastname { Faker::Name.last_name }
		email { Faker::Internet.email }

		#uses the after callback to make sure that a new contact built with the factory will also have one each of the three phone types assigned to it

		after(:build) do |contact|
			[:home_phone, :work_phone, :mobile_phone].each do |phone|
				contact.phones << FactoryGirl.build(:phone, phone_type: phone, contact: contact)
			end
		end
	end
end