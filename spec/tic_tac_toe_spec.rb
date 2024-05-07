require_relative '../tic_tac_toe'

describe Board do
  
  describe '#check_win' do
    context 'when there is a horizontal line win' do
      it 'returns true' do
        board = Board.new
        board.cells = [['X', 'X', 'X'], ['empty', 'O', 'empty'], ['empty', 'O', 'empty']]
        expect(board.check_win).to be true
      end    
    end

    context 'when there is a vertical line win' do
      it 'returns true' do
        board = Board.new
        board.cells = [['X', 'O', 'empty'], ['X', 'O', 'empty'], ['X', 'empty', 'empty']]
        expect(board.check_win).to be true
      end
    end

    context 'when there is a diagonal line win' do
      it 'returns true' do
        board = Board.new
        board.cells = [['X', 'O', 'empty'], ['empty', 'X', 'empty'], ['O', 'empty', 'X']]
        expect(board.check_win).to be true
      end
    end

    context 'when there is no win' do
      it 'returns false' do
        board = Board.new
        board.cells = [['X', 'O', 'empty'], ['empty', 'X', 'empty'], ['O', 'empty', 'O']]
        expect(board.check_win).to be false
      end
    end
  end
end

describe Game do
  let(:game) { Game.new('Player 1', 'X', 'Player 2', 'O') }
  
  describe '#start' do
    it 'makes a move on the board' do
      allow(game.board).to receive(:full?).and_return(false, true)
      allow(game.board).to receive(:check_win).and_return(false)
      expect(game.board).to receive(:move).with(0, 0, 'X').once
      game.start
    end
    
    it 'ends the game when there is a winner' do
      allow(game.board).to receive(:check_win).and_return(true)
      expect(game).to receive(:puts).with(/Congratulations, Player \d+! You just won the game./)
      game.start
    end

    it 'ends the game when there is a draw' do
      allow(game.board).to receive(:check_win).and_return(false)
      allow(game.board).to receive(:full?).and_return(true)
      expect(game).to receive(:puts).with(/It's a draw!/)
      game.start
    end

  end

  describe '#switch_players' do
    it 'switches from player 1 to player 2' do
      game = Game.new('Player 1', 'X', 'Player 2', 'O')
      expect(game.current_player).to eq(game.players[0])
      game.switch_players
      expect(game.current_player).to eq(game.players[1])
    end

    it 'switches from player 2 to player 1' do
      game = Game.new('Player 1', 'X', 'Player 2', 'O')
      game.switch_players 
      expect(game.current_player).to eq(game.players[1])
      game.switch_players 
      expect(game.current_player).to eq(game.players[0])
    end
  end
end