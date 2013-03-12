require 'spec_helper'

describe Address do
  context 'validations' do
    it {should validate_presence_of :street1}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip_code}
    # it {should validate_presence_of :contact_id}
    it {should validate_presence_of :address_type}

    it {should belong_to :contact}
    
  end

  
end
