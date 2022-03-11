# シーン切り替え用ボタンのクラス
class PhBangBang::SceneChangeButton < PhBangBang::Sprite
  def initialize(x, y, image, current_scene, next_scene_class, args1 = nil)
    super(x, y, image)
    @current_scene = current_scene
    @next_scene_class = next_scene_class
    @args1 = args1
  end

  def hit
    @current_scene.change_scene(@next_scene_class, @args1)
    self.collision_enable = false
  end
end
