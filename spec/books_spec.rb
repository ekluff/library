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
      book1.save
      book2 = Books.new({title: 'The World is Flat'})
      book2.save
      expect(Books.find(book2.id)).to(eq(book2))
    end
  end

  # describe('#in?') do
  #   it('returns a boolean of whether book is in library') do
  #     book = Book.new({title: 'Freakonomics'})
  #     book.save
  #     expect(book.in?).to(eq(true))
  #   end
  # end

end
