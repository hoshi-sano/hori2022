# タイトルシーン管理用クラス
class PhBangBang::TitleScene < PhBangBang::BaseScene
  def generate_components
    super
    @defence_components << PBB::Sprite.new(0, 0, DXOpal::Image[:title])
    @defence_components << PBB::SceneChangeButton.new(126, 520, DXOpal::Image[:start_button],
                                                      self, PBB::GameScene)
    @defence_components << PBB::SceneChangeButton.new(10, 620, DXOpal::Image[:story_button],
                                                      self, PBB::SlideScene, :story)
    @defence_components << PBB::SceneChangeButton.new(242, 620, DXOpal::Image[:credit_button],
                                                      self, PBB::SlideScene, :credit)
  end

  def scene_changed
    DXOpal::Sound[:title].loop_play
  end

  def finalize
    DXOpal::Sound[:title].stop
    super
  end
end
