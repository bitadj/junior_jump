require 'rails_helper'

describe Contact do

	it "has a valid factory" do
		expect(build(:contact)).to be_valid
	end

	#testing validations

	it "is valid with a firstname, lastname and email" do 
		contact = Contact.new(
			firstname: 'Aaron', 
			lastname: 'Summer',
			email: 'tester@example.com')
		expect(contact).to be_valid

	end

	it "is invalid without a firstname" do

		contact = build(:contact, firstname: nil)
		contact.valid?
		expect(contact.errors[:firstname]).to include("can't be blank")

	end

	it "is invalid without a lastname" do

		contact = build(:contact, lastname: nil)
			contact.valid?
			expect(contact.errors[:lastname]).to include("can't be blank")

	end

	it "is invalid without an email address" do 

		contact = build(:contact, email: nil)
		contact.valid?
		expect(contact.errors[:email]).to include("can't be blank")

	end

	it "is invalid with a duplicate email address" do

		create(:contact, email: 'tester@example.com')
		contact = build(:contact, email: 'tester@example.com')
		contact.valid?
		expect(contact.errors[:email]).to include("has already been taken")
	end

	it "returns a contact's full name as a string" do
		
		contact = build(:contact, firstname: 'Jane', lastname: 'Smith')

		expect(contact.name).to eq 'Jane Smith'
	end

	describe "filter last name by letter" do
		before :each do
			@smith = Contact.create(
				firstname: 'John',
				lastname: 'Smith',
				email: 'jsmith@example.com'
			)
			@jones = Contact.create(
				firstname: 'Tim',
				lastname: 'Jones',
				email: 'tjones@example.com'
			)
			@johnson = Contact.create(
				firstname: 'John',
				lastname: 'Johnson',
				email: 'jjohnson@example.com'
			)
		end

		context "matching letters" do
			it "returns a sorted array of results that match" do
				expect(Contact.by_letter("J")).to eq [@johnson, @jones]
			end
		end
		context "non-matching letters" do
			it "omits results that do not match" do 
				expect(Contact.by_letter("J")).not_to include @smith
			end
		end
	end	
end