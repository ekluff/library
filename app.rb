require('sinatra')
require('sinatra/reloader')
require('./lib/authors')
require('./lib/books')
require('./lib/checkouts')
require('./lib/patrons')
require('pg')
require('pry')

DB = PG.connect({:dbname => "library"})

get('/') do
  erb(:index)
end

get('/patron/:id') do
  patron_id = params.fetch('id')

  patron = Patrons.find(patron_id)

  @display_books = Books.all()
  @checkout_books = patron.checkouts

  erb(:patron)
end

get('/librarian') do
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
  erb(:index)
end
