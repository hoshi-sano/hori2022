# フィールド上を移動するキャラクターを表現するクラス
class PhBangBang::Character < PhBangBang::Sprite
  WIDTH = PBB::Tile::WIDTH
  HEIGHT = PBB::Tile::HEIGHT
  IMAGES = [
    Image.new(WIDTH, HEIGHT).tap { |img|
      img.circle_fill(WIDTH / 2, HEIGHT / 2, 15, C_RED)
    },
    Image.new(WIDTH, HEIGHT).tap { |img|
      img.circle_fill(WIDTH / 2, HEIGHT / 2, 12, C_RED)
    },
  ]
  IMAGE_UPDATE_FREQ = 30
  OUTLET_TO_INLET = { L: :R, R: :L, U: :D, D: :U }

  def initialize(field)
    @field = field
    @current_tile = @field.tiles.sample
    @current_tile.enter(nil)
    super(@field.x + @current_tile.tx * WIDTH,
          @field.y + @current_tile.ty * HEIGHT,
          IMAGES.first)
    self.collision = [WIDTH / 2, HEIGHT / 2]
    @update_count = 0
  end

  def update
    update_image
    next_x, next_y = @current_tile.next_xy
    self.x = next_x - WIDTH / 2
    self.y = next_y - HEIGHT / 2
    # TODO: タイルをはみ出したときのゲームオーバー判定
  end

  def update_image
    @update_count += 1
    @update_count = @update_count % (IMAGE_UPDATE_FREQ * 2)
    idx = @update_count / IMAGE_UPDATE_FREQ
    self.image = IMAGES[idx]
  end

  def shot(other)
    return if other == @current_tile
    outlet = @current_tile.out
    from = OUTLET_TO_INLET[outlet]
    @current_tile = other
    @current_tile.enter(from)
  end
end
