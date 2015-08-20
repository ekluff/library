class Librarians

  attr_reader :name, :id

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id, nil)
  end

  define_singleton_method(:all) do
    returned_librarians = DB.exec('SELECT * FROM librarians;')
    librarians = []
    returned_librarians.each do |librarian|
      name = librarian.fetch('name')
      id = librarian.fetch('id').to_i
      librarians.push(Librarians.new({:name => name, :id => id}))
    end
    librarians
  end

  def save
    result = DB.exec("INSERT INTO librarians (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first.fetch("id").to_i
  end

  def self.find (id)
    found_librarian = nil
    Librarians.all.each do |librarian|
      if librarian.id == id
        found_librarian = librarian
      end
    end
    found_librarian
  end

  def ==(another_librarian)
    self.id == another_librarian.id
  end

end
