# 水平方向の移動が可能なタイルを表現するクラス
#
# +-----------+
# |           |
# +-----------+
# +-----------+
# |           |
# +-----------+
class PhBangBang::HTile < PhBangBang::Tile
  define_routes({ L: :R, R: :L })
  define_destinations(
    { L_R: (0..80).map { |x| [x, HEIGHT / 2] } }
  )


  class << self
    def image
      DXOpal::Image[:h_tile]
    end

    def highlight_image
      DXOpal::Image[:h_tile_HL]
    end
  end
end
