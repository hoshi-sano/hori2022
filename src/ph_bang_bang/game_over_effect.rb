# ゲーム失敗時のエフェクトを表現するクラス
class PhBangBang::GameOverEffect < PhBangBang::Sprite
  WIDTH = 300
  HEIGHT = 300
  IMAGE = Image.new(WIDTH, HEIGHT, C_WHITE).tap { |img|
    img.draw_font(100, 120, "Oops!!!", Font.default, C_BLACK)
  }
  DISPLAY_TIME = 120

  def initialize
    super(75, 150, IMAGE)
    @count = 0
    @finished = false
  end

  def update
    return if finished?
    super
    @count += 1
    @finished = true if @count > DISPLAY_TIME
  end

  def finished?
    @finished
  end
end
