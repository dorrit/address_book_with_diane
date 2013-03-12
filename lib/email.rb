class Email < ActiveRecord::Base

    validates :email_address, :presence => true
    validates :email_type, :presence => true  
    # validates :contact_id, :presence => true

    belongs_to :contact

end