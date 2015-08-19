require('spec_helper')

describe(Books) do

  describe('.all') do
    it('returns empty book array') do
      expect(Books.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('saves a new book into the database') do
      book = Books.new({title: 'To Kill a Mockingbird'})
      book.save
      expect(Books.all).to(eq([book]))
    end
  end

  describe('.find') do
    it('finds a book based on id') do
      book1 = Books.new({title: 'Moonwalking with Einstein'})
      book.save
      book2 = Books.new({title: 'The World is Flat'})
      book.save
      expect(Books.find(book2.id)).to(eq(book2))
    end
  end
  
end
