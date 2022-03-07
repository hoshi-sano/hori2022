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
    img.box(0, 0, WIDTH - 1, HEIGHT - 1, [0, 100, 100])
  }
  HL_IMAGE = Image.new(WIDTH, HEIGHT, [0, 200, 200]).tap { |img|
    img.box_fill(WIDTH / 2 - 2, 0, WIDTH / 2 + 2, HEIGHT, [200, 0, 0])
    img.box_fill(0, HEIGHT / 2 - 2, WIDTH, HEIGHT / 2 + 2, [200, 0, 0])
    img.box(0, 0, WIDTH - 1, HEIGHT - 1, [0, 100, 100])
  }

  define_routes({ L: :R, R: :L, U: :D, D: :U })
  define_destinations(
    {
      L_R: (0..80).map { |x| [x, HEIGHT / 2] },
      U_D: (0..80).map { |y| [WIDTH / 2, y] },
    }
  )

  class << self
    def image
      BASE_IMAGE
    end

    def highlight_image
      HL_IMAGE
    end
  end
end
