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
