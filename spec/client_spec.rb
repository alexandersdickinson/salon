require('spec_helper')

describe('#delete') do
  it('deletes a client') do
    test_client = @@create_client.call({})
    test_client.save()
    test_client.delete()
    expect(Client.all()).to(eq([]))
  end
end

describe('#update') do
  it('updates a client') do
    test_client = @@create_client.call({})
    test_client.save()
    test_client.update({:last_name => "Smith", :first_name => "John", :stylist_id => 3})
    test_client = Client.find(test_client.id())
    expect(test_client.last_name()).to(eq("Smith"))
    expect(test_client.first_name()).to(eq("John"))
    expect(test_client.stylist_id()).to(eq(3))
  end
end

describe('.find') do
  it('finds a client based on their id') do
    test_client1 = @@create_client.call({})
    test_client1.save()
    test_client2 = @@create_client.call({})
    test_client2.save()
    expect(Client.find(test_client2.id())).to(eq(test_client2))
  end
end

describe('.all') do
  it('starts as an empty array') do
    expect(Client.all()).to(eq([]))
  end
  
  it('returns all saved clients') do
    test_client = @@create_client.call({})
    test_client.save()
    expect(Client.all()).to(eq([test_client]))
  end
end

describe('#==') do
  it('evaluates equality based on first and last names') do
    test_client1 = @@create_client.call({:last_name => "Smith", :first_name => "John"})
    test_client2 = @@create_client.call({:last_name => "Smith", :first_name => "John"})
    expect(test_client1 == test_client2).to(eq(true))
  end
end