# フィールドに1つだけの空きタイルを表現するクラス
class PhBangBang::BlankTile < PhBangBang::Tile
  IMAGE = Image.new(PBB::Tile::WIDTH, PBB::Tile::HEIGHT)

  class << self
    def image
      IMAGE
    end
  end

  def tx=(next_x)
    super
    # 通常のタイルと異なり、即時に指定位置へ移動する
    self.x = @field.x + @tx * WIDTH
  end

  def ty=(next_y)
    super
    # 同上
    self.y = @field.y + @ty * HEIGHT
  end

  def hit
  end
end
