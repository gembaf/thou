describe Game do
  let(:game) { Game.new }
  let(:user) { { id: 'hogehoge', name: 'viewer' } }
  let(:ws) { 'ws_dummy' }

  context '#to_hash' do
    context 'ソケットのみ繋がっている場合' do
      before do
        game.add_client(ws)
        game.update(ws, command: CommandConstants::ADD_CLIENT, current_user: user)
      end

      it { expect(game.to_hash).to eq(users: []) }
    end

    context 'ユーザがサインインしている場合' do
      before do
        game.add_client(ws)
        game.update(ws, command: CommandConstants::ADD_CLIENT, current_user: user)
        game.update(ws, command: CommandConstants::SIGN_IN, current_user: user)
      end

      it do
        expect(game.to_hash)
          .to eq(users: [{ id: 'hogehoge', name: 'viewer' }])
      end
    end
  end
end

