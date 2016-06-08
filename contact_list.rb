require_relative "contact"
require "pry"

class ContactList

  def initialize(args)
    if args.empty?
      command_table
    elsif args[0] == "all"
      all
    elsif args[0] == "new"
      create
    elsif args[0] == "find"
      find
    elsif args[0] == "search"
      search
    elsif args[0] == "update"
      update
    elsif args[0] == "delete"
      destroy
    end
  end

  def command_table
    puts "Here is a list of available commands:"
    puts "    all     ->    Show all contacts"
    puts "    new     ->    Create a new contact"
    puts "    find    ->    Find a contact by ID"
    puts "    search  ->    Search contacts"
    puts "    update  ->    Update an existing contact"
    puts "    delete  ->    Delete an existing contact"
  end

  def user_command
    puts "Enter the command for the contact"
    command = STDIN.gets.chomp.downcase
    case command
    when 'all' 
      p Contact.all
    when "new"
      puts "What's the new contacts' name?"
      name = STDIN.gets.chomp
      puts "What's the contacts' email?"
      email = STDIN.gets.chomp
      p Contact.create(name, email)
    when "find"
      puts "What's the contacts' ID number?"
      id = STDIN.gets.chomp
      p Contact.find(id)
    when "search"
      puts "What would you like to search?"
      term = STDIN.gets.chomp
      p Contact.search(term)
    when "update"
      puts "What's the contacts' ID number?"
      id = STDIN.gets.chomp
      puts "What is the full name?"
      new_name = STDIN.gets.chomp
      puts "What is the email?"
      new_email = STDIN.gets.chomp
    when "delete"
      # destroy
    end
  end

end
contact_list = ContactList.new(ARGV)
# contact_list.command_table
contact_list.user_command
# Contact.create(name, email)