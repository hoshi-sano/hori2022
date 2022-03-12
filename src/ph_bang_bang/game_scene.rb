# ゲームシーン管理用クラス
class PhBangBang::GameScene < PhBangBang::BaseScene
  def generate_components
    super
    bg = PBB::Sprite.new(0, 0, DXOpal::Image[:game_bg]).tap { |b| b.collision_enable = false }
    @field = PBB::Field.new(self)
    @character = PBB::Character.new(self, @field)
    @energy_gage = PBB::EnergyGage.new(@character)
    @close_button =
      PBB::SceneChangeButton.new(400, 10, DXOpal::Image[:back_button], self, PBB::TitleScene)
    @speedup_button =
      PBB::SpeedupButton.new(30, 610, DXOpal::Image[:speedup_button], @character)
    @score_board = PBB::ScoreBoard.new(85, 50, @character)
    @defence_components << bg
    @defence_components << @close_button
    @defence_components << @speedup_button
    @defence_components << @score_board
    @defence_components << @field
    @defence_components << @energy_gage
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
    @offence_components << @game_over_effect
  end

  def add_score(int)
    @score_board.score += int
  end
end
