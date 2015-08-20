require('sinatra')
require('sinatra/reloader')
require('./lib/authors')
require('./lib/books')
require('./lib/checkouts')
require('./lib/patrons')
require('./lib/librarian')
require('pg')
require('pry')

DB = PG.connect({:dbname => "library"})

get('/') do
  @patrons = Patrons.all
  @librarians = Librarians.all
  erb(:index)
end

get('/patron/:id') do
  patron_id = params.fetch('id').to_i

  @patron = Patrons.find(patron_id)
  @display_books = Books.all()
  @checkout_books = @patron.checkouts

  erb(:patron)
end

get('/librarian/:id') do
  librarian_id = params.fetch('id').to_i

  @librarian = Librarians.find(librarian_id)
  @display_books = Books.all()
  @overdue_books = Checkouts.overdue_books

  erb(:librarian)
end

get('/book') do
  erb(:book)
end

post('/patron/new') do
  @name = params.fetch('name')
  patron = Patrons.new({:name => @name})
  patron.save()
  @patrons = Patrons.all
  @librarians = Librarians.all
  erb(:index)
end

post '/patron/checkout/:book_id' do
  book_id = params.fetch('book_id')
  patron_id = params.fetch('patron_id')

  checkout = Checkouts.new({patron_id: patron_id, book_id: book_id})
  checkout.save

  @patron = Patrons.find(patron_id)
  @display_books = Books.all()
  @checkout_books = @patron.checkouts

  erb(:patron)
end

post '/patron/checkin/:book_id' do
  book_id = params.fetch('book_id')
  patron_id = params.fetch('patron_id')
  @patron = Patrons.find(patron_id)

  checkin = @patron.check_in(book_id)
  checkin.save

  @display_books = Books.all()
  @checkout_books = @patron.checkouts

  erb(:patron)
end

post('/librarian/new') do
  @name = params.fetch('name')
  librarian = Librarians.new({:name => @name})
  librarian.save()
  @patrons = Patrons.all
  @librarians = Librarians.all
  erb(:index)
end

post '/book/new' do
  @librarian = params.fetch('librarian')
  title = params.fetch('title')

  Books.new({title: title}).save

  @librarian = Librarians.find(librarian_id)
  @display_books = Books.all()
  @overdue_books = Checkouts.overdue_books

  erb(:librarian)
end
