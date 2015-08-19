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
      book1 = Books.new({:title => 'The Bishop'})
      checkout = Checkouts.new({:patron_id => patron1, :book_id => book1 })
      checkout.save
      expect(Checkouts.all).to(eq([checkout]))
    end
  end

  # describe('.find') do
  #   it('finds a checkout based on id') do
  #     checkout1 = Checkouts.new({title: 'Moonwalking with Einstein'})
  #     checkout1.save
  #     checkout2 = Checkouts.new({title: 'The World is Flat'})
  #     checkout2.save
  #     expect(Checkouts.find(checkout2.id)).to(eq(checkout2))
  #   end
  # end
  #
  # describe('#in?') do
  #   it('returns a boolean of whether checkout is in library') do
  #     checkout = Book.new({title: 'Freakonomics'})
  #     checkout.save
  #     expect(checkout.in?).to(eq(true))
  #   end
  # end

end
