# 左から上へのカーブ、右から下へのカーブの移動が可能なタイルを表現するクラス
#
# +---+-+-----+
# |   | |     |
# +--/ /  ----+
# +----  / /--+
# |     | |   |
# +-----+-+---+
class PhBangBang::LURDTile < PhBangBang::Tile
  define_routes({ L: :U, U: :L, D: :R, R: :D })
  define_destinations(
    {
      L_U: (0..80).map { |n|
        r = rad(270 + n * (90.0/80))
        [(Math.cos(r) * H_W).to_i, -(Math.sin(r) * H_H).to_i]
      },
      R_D: (0..80).map { |n|
        r = rad(90 + n * (90.0/80))
        [WIDTH + (Math.cos(r) * H_W).to_i, HEIGHT - (Math.sin(r) * H_H).to_i]
      },
    }
  )

  class << self
    def image
      DXOpal::Image[:l_u_r_d_tile]
    end

    def highlight_image
      DXOpal::Image[:l_u_r_d_tile_HL]
    end
  end
end
