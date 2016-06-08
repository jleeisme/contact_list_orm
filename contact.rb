require 'pg'

class Contact
  
  attr_accessor :name, :email
  attr_reader :id

  @@conn = PG.connect({
    host: 'localhost',
    dbname: 'contacts',
    user: 'development',
    password: 'development',
    })

  def initialize(name, email, id=nil)
    @id = id
    @name = name
    @email = email
  end

  def save 
    if id
      params = [name, email, id.to_i]
      @@conn.exec("UPDATE contacts SET name=$1, email=$2, WHERE id=$3::int;", params)
    else
      new_save = @@conn.exec("INSERT INTO contacts (name, email) VALUES ($1, $2)
        RETURNING id;", [name, email])
      @id = new_save[0]["id"].to_i
    end
    self
  end

  def self.all
    contact_obj_arr = []
    @@conn.exec("SELECT * FROM contacts ORDER BY id ASC;").each do |contact|
      contact_obj_arr << Contact.new(contact["name"], contact["email"], contact["id"].to_i)
    end
    contact_obj_arr
  end
  # pg goes through each contact and pushes that into the array with their arguments
  # returns the array

  def self.create(name, email)
    new_contact = Contact.new(name, email)
    new_contact.save
    new_contact
  end

  def self.find(id)
    @@conn.exec("SELECT * FROM contacts WHERE id=$1::int;", [id]).first
    the_contact = Contact.find(id)
    the_contact.name = new_name
    the_contact.email = new_email
    the_contact.save
    the_contact
  end
  # pg result is expecting the query and a second 'argument' - also needing it 
  # to be an array. id is called as an [id]array and you need to return the
  # first result. [0], .first

  def self.search(term)
    term = "%#{ term }%"
    @@conn.exec("SELECT name FROM contacts WHERE name like $1", ["%#{ term }%"]).values
    # term is set to what the user inputed with escapes on both sides, selects with
    # the placeholder which is given the term entered and returns all values.
  end

end
