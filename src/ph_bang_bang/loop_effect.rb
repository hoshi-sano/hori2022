# フィールド上を移動するキャラクターを表現するクラス
class PhBangBang::LoopEffect < PhBangBang::Sprite
  INIT_X = 450
  INIT_Y = 300
  MOVE_X = 30
  TTL = 60

  def initialize
    super(INIT_X, INIT_Y, DXOpal::Image[:loop])
    self.visible = false
    self.collision_enable = false
    @ttl = 0
  end

  def activate
    self.visible = true
    self.x = INIT_X
    self.y = INIT_Y
    @ttl = TTL
  end

  def update
    return unless self.visible
    super

    if @ttl < TTL
      @ttl -= 1
      self.visible = false if @ttl <= 0
      return
    end

    center_x = (Window.width / 2) - (self.image.width / 2)
    if self.x >= center_x
      self.x -= MOVE_X
    else
      self.x = center_x
      @ttl -= 1
    end
  end
end
