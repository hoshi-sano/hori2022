# クリックまたはタップ制御用クラス
class PhBangBang::TouchCircle < DXOpal::Sprite
  SIZE = 2

  def initialize(x, y)
    img = Image.new(SIZE, SIZE)
    super(x, y, img)
    self.z = 999
  end

  def update
    self.collision_enable = false
    prev = self.scale_x
    current = prev - 0.1

    if current <= 0
      self.vanish
    else
      self.scale_x = current
      self.scale_y = current
    end
  end
end
