# タイル上に配置される爆弾を表現するクラス
class PhBangBang::Bomb < PhBangBang::TileObject
  WIDTH = 40
  HEIGHT = 40
  IMAGE = Image.new(WIDTH, HEIGHT).tap { |img|
    img.circle_fill(WIDTH / 2, HEIGHT / 2, WIDTH / 2, C_BLACK)
  }

  def touch
    # TODO: 爆発音を鳴らす
    super
    @tile.field.scene.game_over!
  end
end
