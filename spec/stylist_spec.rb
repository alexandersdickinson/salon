require('spec_helper')

describe('#delete') do
  it('deletes a stylist') do
    test_stylist = @@create_stylist.call({})
    test_stylist.save()
    test_stylist.delete()
    expect(Stylist.all()).to(eq([]))
  end
end

describe('#update') do
  it('updates a stylist') do
    test_stylist = @@create_stylist.call({})
    test_stylist.save()
    test_stylist.update({:last_name => "Smith", :first_name => "John", :client_id => 3})
    test_stylist = Stylist.find(test_stylist.id())
    expect(test_stylist.last_name()).to(eq("Smith"))
    expect(test_stylist.first_name()).to(eq("John"))
    expect(test_stylist.client_id()).to(eq(3))
  end
end

describe('.find') do
  it('finds a stylist based on their id') do
    test_stylist1 = @@create_stylist.call({})
    test_stylist1.save()
    test_stylist2 = @@create_stylist.call({})
    test_stylist2.save()
    expect(Stylist.find(test_stylist2.id())).to(eq(test_stylist2))
  end
end

describe('.all') do
  it('starts as an empty array') do
    expect(Stylist.all()).to(eq([]))
  end
  
  it('returns all saved stylists') do
    test_stylist = @@create_stylist.call({})
    test_stylist.save()
    expect(Stylist.all()).to(eq([test_stylist]))
  end
end

describe('#==') do
  it('evaluates equality based on first and last names') do
    test_stylist1 = @@create_stylist.call({:last_name => "Smith", :first_name => "John"})
    test_stylist2 = @@create_stylist.call({:last_name => "Smith", :first_name => "John"})
    expect(test_stylist1 == test_stylist2).to(eq(true))
  end
end