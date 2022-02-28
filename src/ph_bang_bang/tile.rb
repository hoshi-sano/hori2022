# フィールドに並ぶタイルを表現するクラス
class PhBangBang::Tile < PhBangBang::Sprite
  WIDTH = 80
  HEIGHT = 80
  LINE_W = 2
  X_SPEED = WIDTH / 4
  Y_SPEED = HEIGHT / 4

  attr_reader :tx, :ty

  class << self
    def image
      raise NotImplementedError
    end
  end

  def initialize(x, y, field)
    super(field.x + x * WIDTH, field.y + y * HEIGHT, self.class.image)
    @tx = x
    @ty = y
    @field = field
    @moving = false
    @dest_x = nil
    @dest_y = nil
  end

  def tx=(next_x)
    @tx = next_x
    @moving = true
    @dest_x = @field.x + @tx * WIDTH
  end

  def ty=(next_y)
    @ty = next_y
    @moving = true
    @dest_y = @field.y + @ty * HEIGHT
  end

  def update
    super
    update_x
    update_y
  end

  def update_x
    return unless (@moving && @dest_x)
    d = self.x > @dest_x ? -1 : 1
    self.x += d * X_SPEED
    if self.x == @dest_x
      @dest_x = nil
      @moving = false
    end
  end

  def update_y
    return unless (@moving && @dest_y)
    d = self.y > @dest_y ? -1 : 1
    self.y += d * Y_SPEED
    if self.y == @dest_y
      @dest_y = nil
      @moving = false
    end
  end

  def hit(other)
    return if @moving
    return unless other.is_a?(PBB::TouchCircle)
    @field.move(self)
  end
end
