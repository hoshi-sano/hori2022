# 水平・垂直方向の移動が可能なタイルを表現するクラス
#
# +----+-+----+
# |    | |    |
# +----+ +----+
# +----+ +----+
# |    | |    |
# +----+-+----+
class PhBangBang::HVTile < PhBangBang::Tile
  define_routes({ L: :R, R: :L, U: :D, D: :U })
  define_destinations(
    {
      L_R: (0..80).map { |x| [x, HEIGHT / 2] },
      U_D: (0..80).map { |y| [WIDTH / 2, y] },
    }
  )

  class << self
    def image
      DXOpal::Image[:h_v_tile]
    end

    def highlight_image
      DXOpal::Image[:h_v_tile_HL]
    end
  end
end
