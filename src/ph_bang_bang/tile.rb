# フィールドに並ぶタイルを表現するクラス
class PhBangBang::Tile < PhBangBang::Sprite
  WIDTH = 80
  HEIGHT = 80
  LINE_W = 2

  attr_reader :tx, :ty

  class << self
    def image
      color = [rand(255), rand(255), rand(255)]
      image = Image.new(WIDTH, HEIGHT, C_BLACK).tap { |img|
        img.box_fill(LINE_W, LINE_W, WIDTH - LINE_W, HEIGHT - LINE_W, color)
      }
    end
  end

  def initialize(x, y, field)
    super(field.x + x * WIDTH, field.y + y * HEIGHT, self.class.image)
    @tx = x
    @ty = y
    @field = field
  end

  def tx=(next_x)
    @tx = next_x
    self.x = @field.x + @tx * WIDTH
  end

  def ty=(next_y)
    @ty = next_y
    self.y = @field.y + @ty * HEIGHT
  end

  def hit(other)
    return unless other.is_a?(PBB::TouchCircle)
    @field.move(self)
  end
end
