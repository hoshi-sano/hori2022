# 水平・垂直方向の移動が可能なタイルを表現するクラス
#
# +----+-+----+
# |    | |    |
# +----+ +----+
# +----+ +----+
# |    | |    |
# +----+-+----+
class PhBangBang::HVTile < PhBangBang::Tile
  BASE_IMAGE = Image.new(WIDTH, HEIGHT, [0, 200, 200]).tap { |img|
    img.box_fill(WIDTH / 2 - 2, 0, WIDTH / 2 + 2, HEIGHT, [200, 150, 50])
    img.box_fill(0, HEIGHT / 2 - 2, WIDTH, HEIGHT / 2 + 2, [200, 150, 50])
  }

  class << self
    def image
      BASE_IMAGE
    end
  end
end
