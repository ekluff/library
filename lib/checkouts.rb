require 'pry'

 class Checkouts

  attr_reader :book_id, :patron_id, :id, :active, :due_date

  define_method(:initialize) do |attributes|
    @book_id = attributes.fetch(:book_id)
    @patron_id = attributes.fetch(:patron_id)
    @id = attributes.fetch(:id, nil)
    @due_date = Time.now+1209600
    @active = true
  end

  define_singleton_method(:all) do
    returned_checkouts = DB.exec('SELECT * FROM checkouts;')
    checkouts = []
    returned_checkouts.each do |checkout|
      book_id = checkout.fetch('book_id').to_i
      patron_id = checkout.fetch('patron_id').to_i
      id = checkout.fetch('id').to_i
      due_date = Time.parse(checkout.fetch('due_date'))
      active = if checkout.fetch('active') == 'true'
          true
        else
          false
        end
      checkouts.push(Checkouts.new({:book_id => book_id, :patron_id => patron_id, :id => id, :due_date => due_date, :active => active}))
    end
    checkouts
  end

  def save
    result = DB.exec("INSERT INTO checkouts (patron_id, book_id, active, due_date) VALUES ('#{@patron_id}', '#{@book_id}', '#{@active}', '#{@due_date}') RETURNING id;")
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

  def checkouts
    returned_checkouts = DB.exec("SELECT * FROM checkouts WHERE patron_id = '#{patron_id}';")

    checkouts = []
    returned_checkouts.each do |checkout|
      book_id = checkout.fetch('book_id').to_i
      patron_id = checkout.fetch('patron_id').to_i
      id = checkout.fetch('id').to_i
      due_date = Time.parse(checkout.fetch('due_date'))
      active = if checkout.fetch('active') == 'true'
          true
        else
          false
        end
      checkouts.push(Checkouts.new({:book_id => book_id, :patron_id => patron_id, :id => id, :due_date => due_date, :active => active}))
    end
    checkouts
  end

  def self.overdue_books
    returned_checkouts = DB.exec("SELECT * FROM checkouts WHERE active = 'true'")
    overdue_books = []
    returned_checkouts.each do |checkout|
      book_id = checkout.fetch('book_id').to_i
      patron_id = checkout.fetch('patron_id').to_i
      id = checkout.fetch('id').to_i
      due_date = Time.parse(checkout.fetch('due_date'))
      binding.pry
      book_title = Books.find(book_id)
      if due_date < Time.now
        overdue_books.push(Books.new(title: book_title, id: book_id, due_date: due_date))
      end
    end
    overdue_books
  end

  # def self.due_date(book, patron)
  #   returned_checkouts = DB.exec("SELECT * FROM checkouts WHERE book_id = '#{book}' AND patron_id = '#{patron}';")
  #
  #   checkouts = []
  #   returned_checkouts.each do |checkout|
  #     book_id = checkout.fetch('book_id').to_i
  #     patron_id = checkout.fetch('patron_id').to_i
  #     id = checkout.fetch('id').to_i
  #     due_date = checkout.fetch('due_date')
  #     checkouts.push(Checkouts.new({:book_id => book_id, :patron_id => patron_id, :id => id, :due_date => due_date}))
  #   end
  #   checkouts
  #
  # end

  # def due_date (book)
  #   due_date = DB.exec("SELECT due_date FROM checkouts WHERE id = '#{self.id}' AND book_id = '#{book}';")
  # end

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
