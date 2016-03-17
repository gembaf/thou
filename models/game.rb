class Game
  def initialize
    @id = 0
  end

  def users
    @users ||= []
  end

  def add_user(name)
    users << { name: name, id: @id += 1 }
  end

  def to_hash
    {
      users: users
    }
  end
end

