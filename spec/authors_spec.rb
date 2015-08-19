require('spec_helper')

describe(Authors) do

  describe('.all') do
    it('returns empty author array') do
      expect(Authors.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('saves a new author into the database') do
      author = Authors.new({name: 'Harper Lee'})
      author.save
      expect(Authors.all).to(eq([author]))
    end
  end

  describe('.find') do
    it('finds a author based on id') do
      author1 = Authors.new({name: 'Joshue Foer'})
      author1.save
      author2 = Authors.new({name: 'Thomas L. Friedman'})
      author2.save
      expect(Authors.find(author2.id)).to(eq(author2))
    end
  end

end
