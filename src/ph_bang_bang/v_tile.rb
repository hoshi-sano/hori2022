# 垂直方向の移動が可能なタイルを表現するクラス
#
# +----+-+----+
# |    | |    |
# |    | |    |
# |    | |    |
# |    | |    |
# +----+-+----+
class PhBangBang::VTile < PhBangBang::Tile
  BASE_IMAGE = Image.new(WIDTH, HEIGHT, [0, 200, 200]).tap { |img|
    img.box_fill(WIDTH / 2 - 2, 0, WIDTH / 2 + 2, HEIGHT, [200, 150, 50])
  }

  define_routes({ U: :D, D: :U })
  define_destinations(
    { U_D: (0..80).map { |y| [WIDTH / 2, y] } }
  )

  class << self
    def image
      BASE_IMAGE
    end
  end
end
