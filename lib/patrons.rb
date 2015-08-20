class Patrons

  attr_reader :name, :id

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id, nil)
  end

  define_singleton_method(:all) do
    returned_patrons = DB.exec('SELECT * FROM patrons;')
    patrons = []
    returned_patrons.each do |patron|
      name = patron.fetch('name')
      id = patron.fetch('id').to_i
      patrons.push(Patrons.new({:name => name, :id => id}))
    end
    patrons
  end

  def save
    result = DB.exec("INSERT INTO patrons (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first.fetch("id").to_i
  end

  def self.find (id)
    found_patron = nil
    Patrons.all.each do |patron|
      if patron.id == id
        found_patron = patron
      end
    end
    found_patron
  end

  def check_in (book_id)
    @patron_id = self.id
    @book_id = book_id

    DB.exec("UPDATE checkouts SET active = '#{false}' WHERE book_id = '#{@book_id}' AND patron_id = '#{@patron_id}';")
  end

  def books_read
    checkouts = DB.exec("SELECT * FROM checkouts WHERE patron_id = '#{self.id}';")

    book_id_history = []
    checkouts.each do |checkout|
      book_id = patron.fetch('book_id')
      book_id_history.push(book_id)
    end

    books_read = []
    book_id_history.each do |book_id|
      books_read.push(Books.find(book_id))
    end
    books_read
  end

  def checkouts
    returned_checkouts = DB.exec("SELECT * FROM checkouts WHERE patron_id = '#{@id}' AND active = 'true';")

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

  def ==(another_patron)
    self.id == another_patron.id
  end

  def self.find (id)
    Patrons.all.each do |patron|
      if patron.id == id
        return patron
      end
    end
  end

end
