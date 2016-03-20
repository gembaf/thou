class Client
  attr_accessor :name
  attr_accessor :id

  def signin?
    @name
  end

  def to_hash
    {
      id: @id,
      name: @name
    }
  end
end

