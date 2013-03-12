require 'spec_helper'

describe Email do
  context 'validations' do
    it {should validate_presence_of :email_address}
    it {should validate_presence_of :email_type}
    # it {should validate_presence_of :contact_id}    
    it {should belong_to :contact}
    
  end


end