# 右から下へのカーブの移動が可能なタイルを表現するクラス
#
# +-----------+
# |           |
# |       ----+
# |      / /--+
# |     | |   |
# +-----+-+---+
class PhBangBang::RDTile < PhBangBang::Tile
  define_routes({ D: :R, R: :D })
  define_destinations(
    {
      R_D: (0..80).map { |n|
        r = rad(90 + n * (90.0/80))
        [WIDTH + (Math.cos(r) * H_W).to_i, HEIGHT - (Math.sin(r) * H_H).to_i]
      },
    }
  )

  class << self
    def image
      DXOpal::Image[:r_d_tile]
    end

    def highlight_image
      DXOpal::Image[:r_d_tile_HL]
    end
  end
end
