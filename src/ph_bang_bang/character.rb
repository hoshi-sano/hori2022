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

  def initialize(field)
    @field = field
    @current_tile = @field.tiles.sample
    super(@field.x + @current_tile.tx * WIDTH,
          @field.y + @current_tile.ty * HEIGHT,
          IMAGES.first)
    self.collision = [WIDTH / 2, HEIGHT / 2]
    @update_count = 0
  end

  def update
    update_image
    # TODO: タイル内での進行位置を考慮する
    self.x = @current_tile.x
    self.y = @current_tile.y
  end

  def update_image
    @update_count += 1
    @update_count = @update_count % (IMAGE_UPDATE_FREQ * 2)
    idx = @update_count / IMAGE_UPDATE_FREQ
    self.image = IMAGES[idx]
  end
end
