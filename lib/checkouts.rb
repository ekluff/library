class Checkouts

  attr_reader :book_id, :patron_id, :id

  define_method(:initialize) do |attributes|
    @book_id = attributes.fetch(:book_id)
    @patron_id = attributes.fetch(:patron_id)
    @id = attributes.fetch(:id, nil)
  end

  define_singleton_method(:all) do
    returned_checkouts = DB.exec('SELECT * FROM checkouts;')
    checkouts = []
    returned_checkouts.each do |checkout|
      book_id = checkout.fetch('book_id')
      patron_id = checkout.fetch('patron_id')
      id = checkout.fetch('id').to_i
      checkouts.push(Checkouts.new({:book_id => book_id, :patron_id => patron_id, :id => id}))
    end
    checkouts
  end

  def save
    result = DB.exec("INSERT INTO checkouts (patron_id, book_id) VALUES ('#{@patron_id}', '#{@book_id}') RETURNING id;")
    @id = result.first.fetch("id").to_i
  end

  def ==(another_checkout)
    self.id == another_checkout.id
  end

  def self.find (id)
    Checkouts.all.each do |checkout|
      if checkout.id == id
        return checkout
      end
    end
  end

  # def self.in? (search_id)
  #   returned_books = DB.exec("SELECT book_id FROM checkouts WHERE book_id = '#{search_id}';").to_i
  #   if returned_books.class == Fixnum
  #     false
  #   else
  #     true
  #   end
  # end

    # if returned_books == "null"
    #   true
    # else
    #   false
    #get a couple numbers from the database that = books/book ids
    #compare thouse numbers to the parameter we feed into the method 'search_id'
    #if book_id is found in the numbers, return false (checked out)



end
