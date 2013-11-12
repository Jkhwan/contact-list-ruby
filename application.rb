class Application
 
  def initialize
    # Start with an empty array of contacts.
    # TODO: Perhaps stub (seed) some contacts so we don't have to create some every time we restart the app
    @contacts = []
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
    index = input[1] || -1
    case command
    when 'quit'
      puts "Goodbye!"
    when 'new'
      create_new_contact
    when 'list'
      list_contacts
    when 'show'
      show_contact(index)
    end
  end

  def get_name
    puts 'Enter your full name: '
    print '> '
    gets.chomp
  end

  def get_email
    puts 'Enter your email: '
    print '> '
    gets.chomp
  end

  def get_phone
    puts 'Enter your phone number: '
    print '> '
    number = gets.chomp
    puts 'Enter a label: '
    print '> '
    label = gets.chomp
    phone_entry = {}
    phone_entry[label] = number
    return phone_entry
  end

  def create_new_contact
    email = get_email
    return puts "This contact already exists in the system" if @contacts.detect { |contact| contact.email == email }
    full_name = get_name
    contact = Contact.new(full_name, email)
    @contacts.push(contact)
  end

  def list_contacts
    @contacts.each.with_index { |contact, index| puts "#{index}: #{contact}" }
  end

  def show_contact(index)
    index = index.to_i
    return puts "Not found" if index >= @contacts.size || index == -1
    contact = @contacts[index]
    puts contact.display
    loop do
      show_edit_option
      input = gets.chomp
      edit_contact(input, index)
      break if input == 'back'
    end
  end

  def edit_contact(option, index)
    case option
    when 'edit name'
      @contacts[index].edit_name(get_name)
    when 'edit email'
      @contacts[index].edit_email(get_email)
    when 'add phone'
      @contacts[index].add_phone(get_phone)
    end
  end
  
  def show_edit_option
    puts ' add phone  - Add a new phone number to current contact'
    puts ' edit name  - Edit name of current contact'
    puts ' edit email - Edit email of current contact'
    puts ' back       - Back to main menu'
    print '> '
  end

  def show_intro
    puts "Welcome to the app. What's next?"
  end

  # Prints the main menu only
  def show_main_menu
    puts " new      - Create a new contact"
    puts " list     - List all contacts"
    puts " show :id - Display contact details"
    print "> "
  end
 
end