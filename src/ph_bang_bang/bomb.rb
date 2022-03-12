# タイル上に配置される爆弾を表現するクラス
class PhBangBang::Bomb < PhBangBang::TileObject
  WIDTH = 40
  HEIGHT = 40

  class << self
    def image
      DXOpal::Image[:bomb_01]
    end
  end

  def initialize
    super
    @ttl = 3
  end

  def touch
    # TODO: 爆発音を鳴らす
    super
    @tile.field.scene.game_over!
  end

  def moved
    super
    @ttl -= 1
    case @ttl
    when 2
      self.image = DXOpal::Image[:bomb_02]
    when 1
      self.image = DXOpal::Image[:bomb_03]
    when 0
      @tile.field.scene.add_score(1000)
      self.vanish
    end
  end
end
