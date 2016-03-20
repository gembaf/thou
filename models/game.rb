class Game
  include CommandConstants

  def initialize
    @clients = {}
  end

  def update(ws, data)
    user = data[:current_user]
    client = @clients[ws]

    case data[:command]
    when ADD_CLIENT
      client.id = user[:id]
    when SIGN_IN
      client.name = user[:name]
    end
  end

  def send_all
    @clients.each do |ws, _|
      ws.send to_hash.to_json
    end
  end

  def add_client(ws)
    @clients[ws] = Client.new
  end

  def remove_client(ws)
    @clients.delete(ws)
  end

  def to_hash
    {
      users: signin_clients.map(&:to_hash)
    }
  end

  private

  def signin_clients
    @clients.map { |_, client| client }.select(&:signin?)
  end
end

