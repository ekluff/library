require('spec_helper')

describe(Authors) do

  describe('.all') do
    it('returns empty author array') do
      expect(Authors.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('saves a new author into the database') do
      author = Authors.new({title: 'To Kill a Mockingbird'})
      author.save
      expect(Authors.all).to(eq([author]))
    end
  end

  describe('.find') do
    it('finds a author based on id') do
      author1 = Authors.new({title: 'Moonwalking with Einstein'})
      author1.save
      author2 = Authors.new({title: 'The World is Flat'})
      author2.save
      expect(Authors.find(author2.id)).to(eq(author2))
    end
  end

end
