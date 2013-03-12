require 'spec_helper'

describe Phone do
  context 'validations' do
    it {should validate_presence_of :phone_number}
    it {should validate_presence_of :phone_type}
    #it {should validate_presence_of :contact_id} 
    it {should belong_to :contact}   
  end


end