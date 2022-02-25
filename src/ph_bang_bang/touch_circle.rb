# クリックまたはタップ制御用クラス
class PhBangBang::TouchCircle < DXOpal::Sprite
  SIZE = 20

  def initialize(x, y)
    img = Image.new(SIZE, SIZE)
    # TODO: デバッグモードのときのみ円を表示する
    img.circle_fill(SIZE/2, SIZE/2, (SIZE/2)-1, C_RED)
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
