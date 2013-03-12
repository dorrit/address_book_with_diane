class Contact < ActiveRecord::Base
  validates :first_name, :presence => true
  validates :last_name, :presence => true

  has_many :emails
  has_many :phones
  has_many :addresses

  validates :first_name, :format => { :with => /\A[\w\-'\s]+\z/,
  :message => "Only letters allowed" }


  before_save :title_case

  private

  def title_case
    firstname = []
    first_name = self.first_name.split(' ')
    first_name.each {|word| firstname << word.capitalize}
    self.first_name = firstname.join(' ')

    lastname = []
    last_name = self.last_name.split(' ')
    last_name.each {|word| lastname << word.capitalize}
    self.last_name = lastname.join(' ')
  end

end