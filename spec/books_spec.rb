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

end
