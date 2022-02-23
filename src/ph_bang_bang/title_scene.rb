# タイトルシーン管理用クラス
class PhBangBang::TitleScene < PhBangBang::BaseScene
  def initialize
    init
    @bg = Sprite.new(0, 0, Image.new(Window.width, Window.height, C_GREEN))
  end

  def draw_components
    @bg.draw
    Window.draw_font(50, 50, "HORI2022", Font.default, color: C_BLACK)
    super
  end
end
