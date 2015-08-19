class Authors

  attr_reader :name, :id

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id, nil)
  end

  define_singleton_method(:all) do
    returned_authors = DB.exec('SELECT * FROM authors;')
    authors = []
    returned_authors.each do |author|
      name = author.fetch('name')
      id = author.fetch('id').to_i
      authors.push(Authors.new({:name => name, :id => id}))
    end
    authors
  end

  def save
    result = DB.exec("INSERT INTO authors (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first.fetch("id").to_i
  end

  def ==(another_author)
    self.id == another_author.id
  end

  def self.find (id)
    Authors.all.each do |author|
      if author.id == id
        return author
      end
    end
  end

end
