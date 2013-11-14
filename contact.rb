class Contact < ActiveRecord::Base

  has_many :phone_numbers, dependent: :destroy
  
  validates :email, uniqueness: { case_sensitive: false }, presence: true, format: { with: /\A.+@.+\..+\Z/, message: "is not in a valid format" }
  validates :importance, allow_nil: true, numericality: { only_integer: true, greater_than_or_equal_to: 1,
                                         less_than_or_equal_to: 5,
                                         message: "must be between 1 to 5" } 

  def display
  	phones = ""
  	self.phone_numbers.each do |phone_entry|
  		# phone_entry.each do |label, number|
			capitalized_label = phone_entry.label[0].upcase + phone_entry.label[1..-1]
			phones += "\n#{capitalized_label}: #{phone_entry.number}"
  		# end
  	end 
    importance = self.importance || "N/A"
  	"Name: #{first_name} #{last_name}\nEmail: #{email} #{phones}\nImportance: #{importance}".red
  end
  
  def to_s
    "#{first_name} #{last_name[0]} (#{email})"
  end

  # TODO: look up active record to add fullname method to write to
  #       both first_name and last_name
  def full_name=(name)
    full_name = name.split(' ')
    self.first_name = full_name.first
    self.last_name = full_name.last
  end
end