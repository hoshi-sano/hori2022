# フィールドに並ぶタイルを表現するクラス
class PhBangBang::Tile < PhBangBang::Sprite
  WIDTH = 80
  HEIGHT = 80
  LINE_W = 2

  def initialize(x, y, field)
    color = [rand(255), rand(255), rand(255)]
    image = Image.new(WIDTH, HEIGHT, C_BLACK).tap { |img|
      img.box_fill(LINE_W, LINE_W, WIDTH - LINE_W, HEIGHT - LINE_W, color)
    }
    super(field.x + x * WIDTH, field.y + y * HEIGHT, image)
  end
end
