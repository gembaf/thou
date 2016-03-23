class Game
  include CommandConstants

  def initialize
    @clients = {}
    @status = ''
    @votes = {}
    @max_vote = ''
  end

  def update(ws, cmd, current_user)
    client = @clients[ws]
    case cmd
    when ADD_CLIENT
      client.id = current_user[:id]
    when SIGN_IN
      client.name = current_user[:name]
    when GAME_START
      @status = 'GAME'
    when 'VOTE'
      update_vote(current_user[:vote_id])
    end
  end

  def update_vote(vote_id)
    @votes[vote_id] = 0 unless @votes.include?(vote_id)
    @votes[vote_id] += 1
    sum = @votes.values.inject(:+)
    @max_vote = @votes.max_by { |_, v| v }.first if sum == @clients.size
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

  def exist_clients?
    !signin_clients.empty?
  end

  def to_hash
    {
      users: signin_clients.map(&:to_hash),
      max_vote: @max_vote,
      status: @status
    }
  end

  private

  def signin_clients
    @clients.map { |_, client| client }.select(&:signin?)
  end
end

