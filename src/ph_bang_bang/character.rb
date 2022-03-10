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
  INITIAL_SPEED = 10

  attr_reader :speed, :current_tile
  attr_accessor :tmp_speed, :game_over

  def initialize(scene, field)
    @scene = scene
    @update_count = 0
    @speed = INITIAL_SPEED
    @tmp_speed = nil
    @speed_count = 0
    @game_over = false
    @field = field
    @field.character = self
    while
      @current_tile = @field.tiles.sample
      next if @current_tile.is_a?(PBB::BlankTile)
      @current_tile.enter(nil)
      # 必ず2つ以上ルートが繋がっているタイルが初期位置になる
      break if @current_tile.next_tile
    end
    @field.check_routes
    super(@field.x + @current_tile.tx * WIDTH,
          @field.y + @current_tile.ty * HEIGHT,
          IMAGES.first)
    self.collision = [WIDTH / 2, HEIGHT / 2]
  end

  def update
    return if @game_over
    update_image
    update_xy
  end

  def update_image
    @update_count += 1
    @update_count = @update_count % (IMAGE_UPDATE_FREQ * 2)
    idx = @update_count / IMAGE_UPDATE_FREQ
    self.image = IMAGES[idx]
  end

  def update_xy
    @speed_count += 1
    @speed_count = @speed_count % (@tmp_speed || @speed)
    return unless @speed_count.zero?

    next_x, next_y = @current_tile.next_xy
    if next_x.nil?
      # 次のタイルに移る
      next_tile = @current_tile.next_tile
      # フィールドをはみ出すとき、次のタイルがblankのときゲームオーバー判定
      unless next_tile
        @game_over = true
        @scene.game_over!
        return
      end
      enter(next_tile)
    else
      self.x = next_x - WIDTH / 2
      self.y = next_y - HEIGHT / 2
    end
  end

  def enter(next_tile)
    outlet = @current_tile.out
    from = OUTLET_TO_INLET[outlet]
    @current_tile = next_tile
    @current_tile.enter(from)
    @scene.add_score(100) # TODO: スピード等を考慮した点数にする
  end

  def accele
    INITIAL_SPEED - @speed
  end

  def shot(other)
    # TODO: 何かアイテムや障害物に触れたときの処理
  end
end
