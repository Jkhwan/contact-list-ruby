class Application
 
  def run
    show_intro
    loop do
      show_main_menu
      input = gets.chomp
      action(input)
      break if input == 'quit'
    end
  end

  private

  def action(input)
    input = input.split(' ')
    command = input[0]
    argument = input[1] || -1
    case command.downcase
    when 'quit'
      puts "Goodbye!"
    when 'new'
      create_new_contact
    when 'delete'
      delete_contact(argument)
    when 'list'
      list_contacts
    when 'list_most_important'
      list_most_important_contacts
    when 'show'
      show_contact(argument)
    when 'find'
      find_contact(argument)
    else
      puts "Invalid input"
    end
  end

  def get_name
    puts 'Enter your full name: '.light_blue
    print '> '.red
    clean_input(gets)
  end

  def get_email
    puts 'Enter your email: '.light_blue
    print '> '.red
    clean_input(gets)
  end

  def get_importance
    puts 'Enter an importance value (1 to 5): '.light_blue
    print '> '.red
    clean_input(gets)
  end

  def get_phone
    puts 'Enter your phone number: '.light_blue
    print '> '
    number = clean_input(gets)
    puts 'Enter a label: '.light_blue
    print '> '.red
    label = clean_input(gets)
    data = []
    data.push(label).push(number)
  end

  def clean_input(input)
    input.chomp.rstrip
  end

  def display_error(errors)
    errors.full_messages.each { |message| puts message.red }
  end

  def create_new_contact
    contact = Contact.new
    while true
      contact.attributes = {email: get_email}
      break if contact.valid?
      display_error(contact.errors)
    end
    full_name = get_name.split(' ')
    contact.attributes = {first_name: full_name.first, last_name: full_name.last}
    while true
      contact.attributes = {importance: get_importance}
      break if contact.valid?
      display_error(contact.errors)
    end
    contact.save
    puts "Contact created!".red
  end

  def list_contacts
    Contact.all.each { |contact| puts "#{contact.id}: #{contact}".red }
  end

  def list_most_important_contacts
    Contact.where.not(importance: nil).order(importance: :desc).each { |contact| puts "#{contact.id}: #{contact}".red }
  end

  def show_contact(index)
    index = index.to_i
    loop do
      begin
        contact = Contact.find(index)
      rescue
        return puts "Not found".red
      end
      puts contact.display
      show_edit_option
      input = gets.chomp
      edit_contact(input, index)
      break if input == 'back'
    end
  end

  def find_contact(term)
    term = term.downcase
    contacts = Contact.all.select {|contact| contact.first_name.downcase.include?(term) || 
                                             contact.last_name.downcase.include?(term) || 
                                             contact.email.downcase.include?(term)}
    if (contacts.empty?)
      puts "Not found!".red
    else
      contacts.each { |contact| puts "#{contact.display}\n\n"}
    end
  end

  def delete_contact(id)
    contact = Contact.find(id)
    contact.destroy
    puts "Contact deleted!".red
  end

  def edit_contact(option, id)
    case option
    when 'edit name'
      contact = Contact.find(id)
      contact.full_name = get_name
      contact.save
    when 'edit email'
      contact = Contact.find(id)
      while true
        contact.email = get_email
        break if contact.save
        display_error(contact.errors)
      end
    when 'add phone'
      phone_data = get_phone
      # contact = Contact.find(id).add_phone(phone_data[0], phone_data[1])
      Contact.find(id).phone_numbers.create({label: phone_data[0], number: phone_data[1]})
    end
  end
  
  def show_edit_option
    puts ' add phone  - Add a new phone number to current contact'.yellow
    puts ' edit name  - Edit name of current contact'.yellow
    puts ' edit email - Edit email of current contact'.yellow
    puts ' back       - Back to main menu'.yellow
    print '> '.red
  end

  def show_intro
    puts "Welcome to the app. What's next?".yellow
  end

  # Prints the main menu only
  def show_main_menu
    puts " new                  - Create a new contact".yellow
    puts " delete :id           - Delete a contact".yellow
    puts " list                 - List all contacts".yellow
    puts " list_most_important  - List all contacts ordered by importance".yellow
    puts " find :term           - Search the contact details".yellow
    puts " show :id             - Display contact details".yellow
    puts " quit                 - Exit the program".yellow
    print "> ".red
  end
 
end