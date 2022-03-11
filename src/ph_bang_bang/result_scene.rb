# リザルトシーン管理用クラス
class PhBangBang::ResultScene < PhBangBang::BaseScene
  BG = PBB::Sprite.new(0, 0, Image.new(Window.width, Window.height, [0, 100, 100])).
         tap { |bg| bg.collision_enable = false }

  def initialize(score)
    super(nil)
    @score_board = PBB::ScoreBoard.new(75, 500, nil, score)
    @close_button =
      PBB::SceneChangeButton.new(400, 10, DXOpal::Image[:back_button], self, PBB::TitleScene)
    @share_button = PBB::ShareButton.new(200, 575, score)
    @defence_components << BG
    @defence_components << @score_board
    @defence_components << @close_button
    @defence_components << @share_button
  end
end
