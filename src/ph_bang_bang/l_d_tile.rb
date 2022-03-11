# 左から下へのカーブの移動が可能なタイルを表現するクラス
#
# +-----------+
# |           |
# +----       |
# +--\ \      |
# |   | |     |
# +---+-+-----+
class PhBangBang::LDTile < PhBangBang::Tile
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
      DXOpal::Image[:l_d_tile]
    end

    def highlight_image
      DXOpal::Image[:l_d_tile_HL]
    end
  end
end
