require('spec_helper')

describe(Books) do
  describe('.all') do
    it('returns empty book array') do
      expect(Books.all()).to(eq([]))
    end
  end
  
end
