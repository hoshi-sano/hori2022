# 左から上へのカーブの移動が可能なタイルを表現するクラス
#
# +---+-+-----+
# |   | |     |
# +--/ /      |
# +----       |
# |           |
# +-----------+
class PhBangBang::LUTile < PhBangBang::Tile
  define_routes({ L: :U, U: :L })
  define_destinations(
    {
      L_U: (0..80).map { |n|
        r = rad(270 + n * (90.0/80))
        [(Math.cos(r) * H_W).to_i, -(Math.sin(r) * H_H).to_i]
      },
    }
  )

  class << self
    def image
      DXOpal::Image[:l_u_tile]
    end

    def highlight_image
      DXOpal::Image[:l_u_tile_HL]
    end
  end
end
