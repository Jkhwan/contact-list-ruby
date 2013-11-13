class Contact
  
  attr_accessor :first_name
  attr_accessor :last_name
  attr_accessor :phone_numbers
  attr_accessor :email
  
  def initialize(name, email)
    # TODO: assign local variables to instance variables
    full_name = name.split(' ')
    @first_name = full_name[0]
    @last_name = full_name[1] || ""
    @email = email
    @phone_numbers = []
  end

  def display
  	phones = ""
  	@phone_numbers.each do |phone_entry|
  		phone_entry.each do |label, number|
  			capitalized_label = label[0].upcase + label[1..-1]
  			phones += "#{capitalized_label}: #{number}\n"
  		end
  	end 
  	"Name: #{@first_name} #{@last_name}\nEmail: #{@email}\n#{phones}".red
  end
  
  def to_s
    # TODO: return string representation of Contact
    "#{@first_name} #{@last_name[0]} (#{@email})"
  end

  def edit_name(name)
    full_name = name.split(' ')
    @first_name = full_name[0]
    @last_name = full_name[1] || ""
  end

  def edit_email(email)
    @email = email
  end

  def add_phone(label, number)
    phone_entry = {}
    phone_entry[label] = number
  	@phone_numbers.push(phone_entry)
  end

end