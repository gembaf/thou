describe Game do
  let(:game) { Game.new }
  let(:user) { { id: 'hogehoge', name: 'viewer' } }
  let(:ws) { 'ws_dummy' }

  context '#to_hash' do
    context 'ソケットのみ繋がっている場合' do
      before do
        game.add_client(ws)
        game.update(ws, CommandConstants::ADD_CLIENT, user)
      end

      it { expect(game.to_hash[:users]).to eq([]) }
    end

    context 'ユーザがサインインしている場合' do
      before do
        game.add_client(ws)
        game.update(ws, CommandConstants::ADD_CLIENT, user)
        game.update(ws, CommandConstants::SIGN_IN, user)
      end

      it do
        expect(game.to_hash[:users])
          .to eq([{ id: 'hogehoge', name: 'viewer' }])
      end
    end
  end
end

