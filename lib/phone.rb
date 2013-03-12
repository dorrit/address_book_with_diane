class Phone < ActiveRecord::Base

    validates :phone_number, :presence => true
    validates :phone_type, :presence => true
    
    belongs_to :contact

end