class Books

  attr_reader :title, :id

  define_method(:initialize) do |attributes|
    @title = attributes.fetch(:title)
    @id = attributes.fetch(:id, nil)
  end

  define_singleton_method(:all) do
    returned_books = DB.exec('SELECT * FROM books;')
    books = []
    returned_books.each do |book|
      title = book.fetch('title')
      id = book.fetch('id').to_i
      books.push(Books.new({:title => title, :id => id}))
    end
    books
  end

  def save
    result = DB.exec("INSERT INTO books (title) VALUES ('#{@title}') RETURNING id;")
    @id = result.first.fetch("id").to_i
  end

  def ==(another_book)
    self.id == another_book.id
  end

  def self.find (id)
    Books.all.each do |book|
      if book.id == id
        return book
      end
    end
  end

end
