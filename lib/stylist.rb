class Stylist
  attr_reader(:last_name, :first_name, :client_id, :id)
  
  def initialize(attributes)
    @last_name = attributes.fetch(:last_name)
    @first_name = attributes.fetch(:first_name)
    @client_id = attributes.fetch(:client_id)
    @id = attributes.fetch(:id)
  end
  
  def self.all()
    returned_stylists = DB.exec("SELECT * FROM stylists;")
    stylists = []
    returned_stylists.each() do |stylist|
      last_name = stylist.fetch('last_name')
      first_name = stylist.fetch('first_name')
      client_id = stylist.fetch('client_id').to_i()
      id = stylist.fetch('id').to_i()
      stylists.push(Stylist.new({:last_name => last_name, :first_name => first_name, :client_id => client_id, :id => id}))
    end
    stylists
  end
  
  def save()
    id = DB.exec("INSERT INTO stylists (last_name, first_name, client_id) VALUES ('#{@last_name}', '#{@first_name}', #{@client_id}) RETURNING id;")
    @id = id.first().fetch('id').to_i()
  end
  
  def delete()
    DB.exec("DELETE FROM stylists WHERE id = #{self.id()};")
  end
  
  def update(updates)
    attributes = {:last_name => @last_name, :first_name => @first_name, :client_id => @client_id}
    attributes.merge!(updates)
    @last_name = attributes.fetch(:last_name)
    @first_name = attributes.fetch(:first_name)
    @client_id = attributes.fetch(:client_id)
    DB.exec("UPDATE stylists SET last_name = '#{@last_name}', first_name = '#{@first_name}', client_id = #{@client_id} WHERE id = #{self.id()};")
  end
  
  def self.find(id)
    Stylist.all().each() do |stylist|
      return stylist if stylist.id() == id
    end
  end
  
  def ==(comparison)
    self.last_name() == comparison.last_name() && self.first_name() == comparison.first_name()
  end
end