class Application
 
  def initialize
    # Start with an empty array of contacts.
    # TODO: Perhaps stub (seed) some contacts so we don't have to create some every time we restart the app
    @contacts = ContactDatabase.new.read
  end
 
  def run
    show_intro
    loop do
      show_main_menu
      input = gets.chomp
      action(input)
      break if input == 'quit'
    end
  end

  def action(input)
    input = input.split(' ')
    command = input[0]
    argument = input[1] || -1
    case command
    when 'quit'
      write_to_file
      puts "Goodbye!"
    when 'new'
      create_new_contact
    when 'list'
      list_contacts
    when 'show'
      show_contact(argument)
    when 'find'
      find_contact(argument)
    else
      puts "Invalid input"
    end
  end

  def write_to_file
    ContactDatabase.new.write(@contacts)
  end

  def get_name
    puts 'Enter your full name: '.blue
    print '> '.red
    gets.chomp
  end

  def get_email
    puts 'Enter your email: '.blue
    print '> '.red
    gets.chomp
  end

  def get_phone
    puts 'Enter your phone number: '.blue
    print '> '
    number = gets.chomp
    puts 'Enter a label: '.blue
    print '> '.red
    label = gets.chomp
    data = []
    data.push(label).push(number)
  end

  def create_new_contact
    email = get_email
    return puts "This contact already exists in the system".red if @contacts.detect { |contact| contact.email == email }
    full_name = get_name
    contact = Contact.new(full_name, email)
    @contacts.push(contact)
  end

  def list_contacts
    @contacts.each.with_index { |contact, index| puts "#{index}: #{contact}".red }
  end

  def show_contact(index)
    index = index.to_i
    return puts "Not found" if index >= @contacts.size || index == -1
    contact = @contacts[index]
    loop do
      puts contact.display
      show_edit_option
      input = gets.chomp
      edit_contact(input, index)
      break if input == 'back'
    end
  end

  def find_contact(term)
    @contacts.each do |contact|
      if contact.first_name.include?(term) || contact.last_name.include?(term) || contact.email.include?(term)
        puts contact.display
      end
    end
  end

  def edit_contact(option, index)
    case option
    when 'edit name'
      @contacts[index].edit_name(get_name)
    when 'edit email'
      @contacts[index].edit_email(get_email)
    when 'add phone'
      phone_data = get_phone
      @contacts[index].add_phone(phone_data[0], phone_data[1])
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
    puts " new         - Create a new contact".yellow
    puts " list        - List all contacts".yellow
    puts " find :term  - Search the contact details".yellow
    puts " show :id    - Display contact details".yellow
    print "> ".red
  end
 
end