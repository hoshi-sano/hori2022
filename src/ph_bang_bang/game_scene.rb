# ゲームシーン管理用クラス
class PhBangBang::GameScene < PhBangBang::BaseScene
  BG = PBB::Sprite.new(0, 0, Image.new(Window.width, Window.height, [0, 200, 200])).
         tap { |bg| bg.collision_enable = false }
  BACK_IMAGE = Image.new(30, 30, C_WHITE).tap { |img|
    img.draw_font(5, 5, "X", Font.default, C_BLACK)
  }

  def generate_components
    super
    @components << BG
    @components << PBB::SceneChangeButton.new(410, 10, BACK_IMAGE, self, PBB::TitleScene)
    @components << PBB::Field.new
  end
end
