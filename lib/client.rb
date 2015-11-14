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
    clients = []
    returned_clients.each() do |client|
      last_name = client.fetch('last_name')
      first_name = client.fetch('first_name')
      stylist_id = client.fetch('stylist_id').to_i()
      id = client.fetch('id').to_i()
      clients.push(Client.new({:last_name => last_name, :first_name => first_name, :stylist_id => stylist_id, :id => id}))
    end
    clients
  end
  
  def save()
    id = DB.exec("INSERT INTO clients (last_name, first_name, stylist_id) VALUES ('#{@last_name}', '#{@first_name}', #{@stylist_id}) RETURNING id;")
    @id = id.first().fetch('id').to_i()
  end
  
  def delete()
    DB.exec("DELETE FROM clients WHERE id = #{self.id()};")
  end
  
  def update(updates)
    attributes = {:last_name => @last_name, :first_name => @first_name, :stylist_id => @stylist_id}
    attributes.merge!(updates)
    @last_name = attributes.fetch(:last_name)
    @first_name = attributes.fetch(:first_name)
    @stylist_id = attributes.fetch(:stylist_id)
    DB.exec("UPDATE clients SET last_name = '#{@last_name}', first_name = '#{@first_name}', stylist_id = #{@stylist_id} WHERE id = #{self.id()};")
  end
  
  def self.find(id)
    Client.all().each() do |client|
      return client if client.id() == id
    end
  end
  
  def ==(comparison)
    self.last_name() == comparison.last_name() && self.first_name() == comparison.first_name()
  end
end