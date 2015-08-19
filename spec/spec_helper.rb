require ('rspec')
require('patrons')
require('books')
require('authors')
require('checkouts')
require('pg')

DB = PG.connect({:dbname => 'library_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM books *;")
    DB.exec("DELETE FROM patrons *;")
    DB.exec("DELETE FROM authors *;")
    DB.exec("DELETE FROM checkouts *;")
  end
end
