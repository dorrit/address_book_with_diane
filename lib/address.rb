class Address < ActiveRecord::Base

    validates :street1, :presence => true
    validates :city, :presence => true
    validates :state, :presence => true
    validates :zip_code, :presence => true
    validates :address_type, :presence => true

    belongs_to :contact
end