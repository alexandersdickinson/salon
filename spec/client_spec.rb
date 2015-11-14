require('spec_helper')

describe('#save') do
end

describe('.find') do
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