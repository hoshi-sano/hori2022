# タイル上に配置される爆弾を表現するクラス
class PhBangBang::Bomb < PhBangBang::TileObject
  WIDTH = 40
  HEIGHT = 40
  IMAGE = Image.new(WIDTH, HEIGHT).tap { |img|
    img.circle_fill(WIDTH / 2, HEIGHT / 2, WIDTH / 2, C_BLACK)
  }
  DAMAGED_IMAGE_1 = Image.new(WIDTH, HEIGHT).tap { |img|
    img.circle_fill(WIDTH / 2, HEIGHT / 2, WIDTH / 2, [200, 200, 200])
  }
  DAMAGED_IMAGE_2 = Image.new(WIDTH, HEIGHT).tap { |img|
    img.circle_fill(WIDTH / 2, HEIGHT / 2, WIDTH / 2, [10, 100, 100])
  }

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
      self.image = DAMAGED_IMAGE_1
    when 1
      self.image = DAMAGED_IMAGE_2
    when 0
      self.vanish
    end
  end
end
