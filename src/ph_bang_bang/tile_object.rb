# タイル上に配置されるオブジェクトを表現するクラス
class PhBangBang::TileObject < PhBangBang::Sprite
  def initialize(tile)
    @tile = tile
    image = self.class.image
    @dx = (@tile.width / 2) - (image.width / 2)
    @dy = (@tile.height / 2) - (image.height / 2)
    super(@tile.x + @dx, @tile.y + @dy, image)
  end

  def update(tile_moving)
    super
    return if tile_moving
    # タイルに連れ添うよう位置調整
    self.x = @tile.x + @dx
    self.y = @tile.y + @dy
  end

  def touch
    self.vanish
  end

  def moved
  end
end
