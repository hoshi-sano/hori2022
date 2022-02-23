# タイトルシーン管理用クラス
class PhBangBang::TitleScene < PhBangBang::BaseScene
  BG = PBB::Sprite.new(0, 0, Image.new(Window.width, Window.height, C_GREEN))

  def generate_components
    super
    @components << BG
  end

  def draw_components
    super
    Window.draw_font(50, 50, "HORI2022", Font.default, color: C_BLACK)
  end
end
