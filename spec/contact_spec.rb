require 'spec_helper'

describe Contact do
  context 'validations' do
    it {should validate_presence_of :first_name}
    it {should validate_presence_of :last_name}
    
  end

  it {should have_many :emails}

# describe Contact do
#   context 'validations' do
#     it 'validates the presence of name' do
#       contact = Contact.new(:first_name => "", :last_name=> "")
#       contact.save.should be_false
#     end
#   end



end