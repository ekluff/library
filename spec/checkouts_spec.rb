require 'pry'
require('spec_helper')

describe(Checkouts) do

  describe('.all') do
    it('returns empty checkout array') do
      expect(Checkouts.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('saves a new checkout into the database') do
      patron1 = Patrons.new({:name => 'Anton Chekov'}).save()
      book1 = Books.new({:title => 'The Bishop'}).save()
      checkout = Checkouts.new({:patron_id => patron1, :book_id => book1})
      checkout.save
      expect(Checkouts.all).to(eq([checkout]))
    end
  end

  describe('.find') do
    it('finds a checkout based on id') do
      checkout1 = Checkouts.new({:book_id => 2, :patron_id => 1})
      checkout1.save
      checkout2 = Checkouts.new({:book_id => 3, :patron_id => 4})
      checkout2.save
      expect(Checkouts.find(checkout2.id)).to(eq(checkout2))
    end
  end

  describe('.due_date') do
    it('returns a due date for a book') do
      patron1 = Patrons.new({:name => 'John Francis Kennedy'}).save()
      book1 = Books.new({:title => 'Death of a President'}).save()
      checkout = Checkouts.new({:patron_id => patron1, :book_id => book1, :due_date => 'November 22, 1963'})
      checkout.save
      expect(Checkouts.due_date(book1, patron1)).to(eq([checkout]))
    end
  end

  # describe('#in?') do
  #   it('returns a boolean of whether checkout is in library') do
  #     book = Books.new({title: 'Freakonomics'})
  #     book.save
  #     patron = Patrons.new({name: 'Joe White'})
  #     patron.save
  #     checkout = Checkouts.new({book_id: book.id, patron_id: patron.id})
  #     checkout.save
  #     binding.pry
  #     expect(in?(book.id)).to(eq(true))
  #   end
  # end

end
