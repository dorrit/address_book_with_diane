require 'active_record'
require './lib/contact'
require './lib/phone'
require './lib/email'
require './lib/address'

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations["development"]
ActiveRecord::Base.establish_connection(development_configuration)

def welcome
  puts "Welcome to Diane's and Dorrit's Little Black Book\n\n"
  menu
end

def menu
  choice = nil
  until choice == 'x'
    puts "\n\n    MAIN MENU"
    puts "Press 'a' to add a contact."
    puts "Press 'd' to delete a contact."    
    puts "Press 'e' to edit a contact."    
    puts "Press 'l' to list all of your contacts by name."       
    puts "Press 'v' to view a contact."
    puts "Press 'x' to exit."
    case choice = gets.chomp
    when 'a'
      add_contact
    when 'd'
      delete_contact    
    when 'e'
      edit_contact    
    when 'l'
      list_contacts 
    when 'v'
      view_contact
    when 'x'
      exit    
    else
      puts "FAIL! Try again!"
    end
  end
end

def list_contacts
  puts "Here are your contacts:"
  contacts = Contact.all
  contacts.each {|contact| puts "#{contact.id} #{contact.last_name}, #{contact.first_name}"}
end

def add_contact
  print "Enter the new contact's first name:  "
  first_name = gets.chomp
  print "Enter the new contact's last name:  "
  last_name = gets.chomp
  contact = Contact.new(:first_name => first_name, :last_name => last_name)
  if contact.save
    puts "#{contact.first_name} #{contact.last_name} has been added to your Little Black Book."
    add_menu(contact)
  else
    puts "That wasn't a valid contact name."
  end  
end

def add_email(contact)
  print "Enter the new contact's email address:  "
  email_address = gets.chomp
  print "Enter the email type (h = home, w = work):  "
  email_type = gets.chomp
  email = Email.new(:email_address => email_address, :contact_id => contact.id, :email_type => email_type)
  if email.save
    puts "#{email_address} for #{contact.first_name} #{contact.last_name} has been added to your Little Black Book."
  else
    puts "That wasn't a valid email address."
  end  
end

def add_phone(contact)
  print "Enter the contact's phone number:  "
  phone_number = gets.chomp
  print "Enter the email type (h = home, w = work, m = mobile):  "
  phone_type = gets.chomp
  phone = Phone.new(:phone_number => phone_number, :contact_id => contact.id, :phone_type => phone_type)
  if phone.save
    puts "#{phone_number} for '#{contact.first_name} #{contact.last_name} has been added to your Little Black Book."
  else
    puts "That wasn't a valid phone number."
  end  
end

def add_address(contact)
  print "Enter the contact's street address:  "
  street1 = gets.chomp
  print "Enter the apartment number:  "
  street2 = gets.chomp
  print "Enter the city:  "
  city = gets.chomp
  print "Enter the two letter abbreviation for the state:  "
  state = gets.chomp
  print "Enter the 5 digit zip code:  "
  zip_code = gets.chomp
  print "Enter the address type (h = home, w = work):  "
  address_type = gets.chomp
  address = Address.new(:street1 => street1, :street2 => street2, :city => city, :state => state, 
                        :zip_code => zip_code, :contact_id => contact.id, :address_type => address_type)
  if address.save
    puts "'An address for #{contact.first_name} #{contact.last_name} has been added to your Little Black Book."
  else
    puts "That wasn't a valid address."
  end  
end

def add_menu(contact)
  choice = nil
  until choice == 'x'
    puts " \n\n    CONTACT INFO MENU"
    puts "Press 'a' to add an address."
    puts "Press 'e' to add an email address."
    puts "Press 'p' to add a phone."
    puts "Press 'x' to return to main menu."
    case choice = gets.chomp
    when 'a'
      add_address(contact)
    when 'e'
      add_email(contact)
    when 'p'
      add_phone(contact) 
    when 'x'
      return
    else
      puts "FAIL! Try again!"
    end
  end  
end

def view_contact
  puts "Here is a list of contacts by name and id:"
  list_contacts
  print "Enter the id of the contact you would like to view:  "
  contact_id = gets.chomp
  contact = Contact.find(contact_id)
  # address = Address.where(:contact_id => contact_id).first
  # phone = Phone.where(:contact_id => contact_id).first
  # email = Email.where(:contact_id => contact_id).first
  emails = contact.emails.first
  phones = contact.phones.first
  addresses = contact.addresses.first
  puts "first name:     #{contact.first_name}"
  puts "last name:      #{contact.last_name}"
  puts "email:          #{emails.email_address} (#{emails.email_type})" 
  puts "phone:          #{phones.phone_number} (#{phones.phone_type})" 
  puts "street address: #{addresses.street1}, #{addresses.street2}  (#{addresses.address_type})"
  puts "city:           #{addresses.city}"
  puts "state:          #{addresses.state}"
  puts "zip code:       #{addresses.zip_code}"
end

def delete_contact
  puts "Here is a list of contacts by name and id:"
  list_contacts
  print "Enter the id of the contact you would like to delete:  "
  contact_id = gets.chomp
  contact = Contact.find(contact_id)
  contact.destroy
  puts "'#{contact.first_name} #{contact.last_name}' has been deleted from your Little Black Book."
end

def edit_contact
  puts "Here is a list of contacts by name and id:"
  list_contacts
  print "Enter the id of the contact you would like to edit:  "
  contact_id = gets.chomp
  contact = Contact.find(contact_id)

  choice = nil
  until choice == 's'
    puts "Press 'n' to modify the name."
    #puts "Press 'a' to modify the address."
    puts "Press 's' to save changes."
    case choice = gets.chomp
    when 'n'
      print "Enter the contact's new first name:  "
      first_name = gets.chomp
      print "Enter the contact's new last name:  "
      last_name = gets.chomp
      # contact = Contact.new(:first_name => first_name, :last_name => last_name)
    when 's'
      puts "New name: '#{first_name} #{last_name}'"
      print "Are you sure you want to save these changes(y/n):  "
      if gets.chomp == 'y'
        contact.update_attributes(:first_name => first_name, :last_name => last_name)
      else
        return
      end
    else
      Puts "FAIL! Try again!"
    end
  end  
  puts "New name: '#{contact.first_name} #{contact.last_name}'"
end

welcome