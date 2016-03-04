describe Game do
  let(:game) { Game.new }

  before { game.add_user 'viewer1' }

  context '#add_user' do
    before { game.add_user 'viewer2' }

    it '1番目が登録されていること' do
      expect(game.users[0][:name]).to eq 'viewer1'
      expect(game.users[0][:id]).to eq 1
    end

    it '2番目が登録されていること' do
      expect(game.users[1][:name]).to eq 'viewer2'
      expect(game.users[1][:id]).to eq 2
    end
  end

  context '#to_hash' do
    it do
      expect(game.to_hash)
        .to eq(users: [{ name: 'viewer1', id: 1 }])
    end
  end
end

