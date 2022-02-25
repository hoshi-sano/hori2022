# フィールドに1つだけの空きタイルを表現するクラス
class PhBangBang::BlankTile < PhBangBang::Tile
  IMAGE = Image.new(PBB::Tile::WIDTH, PBB::Tile::HEIGHT)

  class << self
    def image
      IMAGE
    end
  end

  def hit
  end
end
