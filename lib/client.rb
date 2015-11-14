class Client
  attr_reader(:last_name, :first_name, :stylist_id, :id)
  
  def initialize(attributes)
    @last_name = attributes.fetch(:last_name)
    @first_name = attributes.fetch(:first_name)
    @stylist_id = attributes.fetch(:stylist_id)
    @id = attributes.fetch(:id)
  end
  
  def self.all()
    returned_clients = DB.exec("SELECT * FROM clients;")
    clients
  end
  
  def save()
    id = DB.exec("INSERT INTO clients (last_name, first_name) VALUES ('#{@last_name}, #{@first_name}') RETURNING id;")
    @id = id.first().fetch('id').to_i()
  end
end