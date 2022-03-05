# 左から下へのカーブ、右から上へのカーブの移動が可能なタイルを表現するクラス
#
# +-----+-+---+
# |     | |   |
# +----  \ \--+
# +--\ \  ----+
# |   | |     |
# +---+-+-----+
class PhBangBang::LDRUTile < PhBangBang::Tile
  BASE_IMAGE = Image.new(WIDTH, HEIGHT, [0, 200, 200]).tap { |img|
    img.circle_fill(WIDTH, 0, WIDTH / 2, [200, 150, 50])
    img.circle_fill(WIDTH, 0, WIDTH / 2 - 3, [0, 200, 200])
    img.circle_fill(0, HEIGHT, WIDTH / 2, [200, 150, 50])
    img.circle_fill(0, HEIGHT, WIDTH / 2 - 3, [0, 200, 200])
  }

  define_routes({ L: :D, D: :L, U: :R, R: :U })
  define_destinations(
    {
      D_L: (0..80).map { |n|
        r = rad(n * (90.0/80))
        [(Math.cos(r) * H_W).to_i, HEIGHT - (Math.sin(r) * H_H).to_i]
      },
      U_R: (0..80).map { |n|
        r = rad(180 + n * (90.0/80))
        [WIDTH + (Math.cos(r) * H_W).to_i, -(Math.sin(r) * H_H).to_i]
      },
    }
  )

  class << self
    def image
      BASE_IMAGE
    end
  end
end
