# 左から下へのカーブの移動が可能なタイルを表現するクラス
#
# +-----------+
# |           |
# +----       |
# +--\ \      |
# |   | |     |
# +---+-+-----+
class PhBangBang::LDTile < PhBangBang::Tile
  BASE_IMAGE = Image.new(WIDTH, HEIGHT, [0, 200, 200]).tap { |img|
    img.circle_fill(0, HEIGHT, WIDTH / 2, [200, 150, 50])
    img.circle_fill(0, HEIGHT, WIDTH / 2 - 3, [0, 200, 200])
  }

  define_routes({ L: :D, D: :L })

  class << self
    def image
      BASE_IMAGE
    end
  end
end
