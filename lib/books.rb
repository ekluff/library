class Books

  attr_reader :title, :id

  define_method(:initialize) do |attributes|
    @title = attributes.fetch(:title)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_books = DB.exec('SELECT * FROM books;')
    books = []
    returned_books.each do |book|
      title = book.fetch('title')
      id = book.fetch('id')
      books.push(Books.new({:title => title, :id => id}))
    end
    books
  end





end
