require('spec_helper')

describe(Patrons) do

  describe('.all') do
    it('returns empty patron array') do
      expect(Patrons.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('saves a new patron into the database') do
      patron = Patrons.new({name: 'Harper Lee'})
      patron.save
      expect(Patrons.all).to(eq([patron]))
    end
  end

  describe('.find') do
    it('finds a patron based on id') do
      patron1 = Patrons.new({name: 'John Q. Public'})
      patron1.save
      patron2 = Patrons.new({name: 'Jane Doe'})
      patron2.save
      expect(Patrons.find(patron2.id)).to(eq(patron2))
    end
  end

end
