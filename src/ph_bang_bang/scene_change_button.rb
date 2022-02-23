# シーン切り替え用ボタンのクラス
class PhBangBang::SceneChangeButton < PhBangBang::Sprite
  def initialize(x = 0, y = 0, image = nil, current_scene, next_scene_class)
    super(x, y, image)
    @current_scene = current_scene
    @next_scene_class = next_scene_class
  end

  def hit
    @current_scene.change_scene(@next_scene_class)
    self.collision_enable = false
  end
end
