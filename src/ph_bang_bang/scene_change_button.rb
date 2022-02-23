# シーン切り替え用ボタンのクラス
class PhBangBang::SceneChangeButton < PhBangBang::Sprite
  def initialize(x = 0, y = 0, image = nil, next_scene)
    super(x, y, image)
    @next_scene = next_scene
  end

  def hit
    # TODO: シーン切り替え
    self.image = Image.new(350, 100, C_WHITE).tap { |img|
      img.draw_font(0, 30, Time.now.to_s, Font.default, C_BLACK)
    }
    self.collision_enable = false
  end
end
