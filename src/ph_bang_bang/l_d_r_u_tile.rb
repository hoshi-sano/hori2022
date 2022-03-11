# 左から下へのカーブ、右から上へのカーブの移動が可能なタイルを表現するクラス
#
# +-----+-+---+
# |     | |   |
# +----  \ \--+
# +--\ \  ----+
# |   | |     |
# +---+-+-----+
class PhBangBang::LDRUTile < PhBangBang::Tile
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
      DXOpal::Image[:l_d_r_u_tile]
    end

    def highlight_image
      DXOpal::Image[:l_d_r_u_tile_HL]
    end
  end
end
