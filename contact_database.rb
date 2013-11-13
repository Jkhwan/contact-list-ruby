class ContactDatabase

	def read
		@data_file = File.new("data.txt", "r+")
		contacts = []
		@data_file.each_line do |line|
			contacts.push(generate_contact(line))
		end
		contacts
	end

	def generate_contact(line)
		contact = Contact.new("", "")
		fields = line.split(', ')
		fields.each do |field|
			field_array = field.split('=')
			type = field_array[0]
			data = field_array[1].chomp
			case type
			when 'name'
				contact.edit_name(data)
			when 'email'
				contact.edit_email(data)
			else
				contact.add_phone(type, data)
			end
		end
		contact
	end

	def write(contacts)
		@data_file = File.new("data.txt", "w+")
		contacts.each do |contact|
			text = "name=#{contact.first_name} #{contact.last_name}, email=#{contact.email}"
			contact.phone_numbers.each do |phone_entry|
				phone_entry.each do |label, number|
					text += ", #{label}=#{number}"
				end
			end
			@data_file.puts(text)
		end
	end

end