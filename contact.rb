class Contact
  
  attr_accessor :first_name
  attr_accessor :last_name
  attr_accessor :email
  
  def initialize(name, email)
    # TODO: assign local variables to instance variables
    full_name = name.split(' ')
    @first_name = full_name[0]
    @last_name = full_name[1] || ""
    @email = email
  end

  def display
  	"#{@first_name} #{@last_name}\n#{@email}"
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
  
end