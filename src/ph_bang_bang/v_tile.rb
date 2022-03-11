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
    img.box(0, 0, WIDTH - 1, HEIGHT - 1, [0, 100, 100])
  }
  HL_IMAGE = Image.new(WIDTH, HEIGHT, [0, 200, 200]).tap { |img|
    img.box_fill(WIDTH / 2 - 2, 0, WIDTH / 2 + 2, HEIGHT, [200, 0, 0])
    img.box(0, 0, WIDTH - 1, HEIGHT - 1, [0, 100, 100])
  }

  define_routes({ U: :D, D: :U })
  define_destinations(
    { U_D: (0..80).map { |y| [WIDTH / 2, y] } }
  )

  class << self
    def image
      DXOpal::Image[:v_tile]
    end

    def highlight_image
      DXOpal::Image[:v_tile_HL]
    end
  end
end
