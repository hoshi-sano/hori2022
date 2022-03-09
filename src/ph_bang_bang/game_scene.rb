# ゲームシーン管理用クラス
class PhBangBang::GameScene < PhBangBang::BaseScene
  BG = PBB::Sprite.new(0, 0, Image.new(Window.width, Window.height, [0, 200, 200])).
         tap { |bg| bg.collision_enable = false }
  BACK_IMAGE = Image.new(30, 30, C_WHITE).tap { |img|
    img.draw_font(5, 5, "X", Font.default, C_BLACK)
  }
  SPEEDUP_IMAGE = Image.new(50, 50, C_WHITE).tap { |img|
    img.draw_font(10, 10, "Q", Font.default, C_BLACK)
  }

  def generate_components
    super
    @field = PBB::Field.new(self)
    @character = PBB::Character.new(self, @field)
    @close_button = PBB::SceneChangeButton.new(410, 10, BACK_IMAGE, self, PBB::TitleScene)
    @speedup_button = PBB::SpeedupButton.new(200, 130, SPEEDUP_IMAGE, @character)
    @score_board = PBB::ScoreBoard.new(75, 50)
    @defence_components << BG
    @defence_components << @close_button
    @defence_components << @speedup_button
    @defence_components << @score_board
    @defence_components << @field
    @defence_components.concat(@field.tiles)
    @offence_components << @character
  end

  def play
    if @game_over
      PBB.change_scene(@next_scene_class, @scene_change_arg1) if @finalized
      @game_over_effect.update
      change_scene(PBB::ResultScene, @score_board.score) if @game_over_effect.finished?
      draw_components
      check_keys
      DXOpal::Sprite.check(@offence_components, [@close_button])
    else
      super
    end
  end

  def game_over!
    PBB::Logger.debug "GameScene#game_over! called."
    @game_over = true
    @character.game_over = true
    @game_over_effect = PBB::GameOverEffect.new
    @defence_components << @game_over_effect
  end

  def add_score(int)
    @score_board.score += int
  end
end
