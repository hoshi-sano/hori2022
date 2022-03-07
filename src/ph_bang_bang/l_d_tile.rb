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
    img.box(0, 0, WIDTH - 1, HEIGHT - 1, [0, 100, 100])
  }
  HL_IMAGE = Image.new(WIDTH, HEIGHT, [0, 200, 200]).tap { |img|
    img.circle_fill(0, HEIGHT, WIDTH / 2, [200, 0, 0])
    img.circle_fill(0, HEIGHT, WIDTH / 2 - 3, [0, 200, 200])
    img.box(0, 0, WIDTH - 1, HEIGHT - 1, [0, 100, 100])
  }

  define_routes({ L: :D, D: :L })
  define_destinations(
    {
      D_L: (0..80).map { |n|
        r = rad(n * (90.0/80))
        [(Math.cos(r) * H_W).to_i, HEIGHT - (Math.sin(r) * H_H).to_i]
      },
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
