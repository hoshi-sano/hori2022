# ゲーム失敗時のエフェクトを表現するクラス
class PhBangBang::GameOverEffect < PhBangBang::Sprite
  WIDTH = 300
  HEIGHT = 300
  DISPLAY_TIME = 120

  def initialize
    super(3, 150, DXOpal::Image[:oops])
    @count = 0
    @finished = false
    collision_enable = false
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
