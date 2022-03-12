# タイルが並ぶフィールドを表現するクラス
class PhBangBang::Field < PhBangBang::Sprite
  attr_reader :tiles, :scene, :character

  WIDTH = 400
  HEIGHT = 400
  IMAGE = Image.new(WIDTH, HEIGHT)
  X_TILE_NUM = WIDTH / PBB::Tile::WIDTH
  Y_TILE_NUM = HEIGHT / PBB::Tile::HEIGHT
  TILE_TYPE_TO_NUMS = {
    PBB::HTile => 2,
    PBB::VTile => 2,
    PBB::HVTile => 4,
    PBB::LDRUTile => 4,
    PBB::LDTile => 2,
    PBB::RUTile => 2,
    PBB::LURDTile => 4,
    PBB::LUTile => 2,
    PBB::RDTile => 2,
  }
  MOVE_EFFECT_FREQ = 7
  MOVE_EFFECT_BUFFER = 4

  def initialize(scene)
    @scene = scene
    x = CENTER_X - (IMAGE.width / 2)
    y = CENTER_Y - (IMAGE.height / 2)
    super(x, y, IMAGE)
    self.collision_enable = false

    tile_types = TILE_TYPE_TO_NUMS.map { |t, num| [t] * num }.flatten.shuffle
    @tiles = []
    X_TILE_NUM.times do |x|
      Y_TILE_NUM.times do |y|
        next if x == X_TILE_NUM - 1 && y == Y_TILE_NUM - 1
        @tiles << tile_types.shift.new(x, y, self)
      end
    end

    @blank_tile = PBB::BlankTile.new(4, 4, self)
    @tiles << @blank_tile
  end

  def character=(c)
    @character = c
    reset_move_effect_count
  end

  def reset_move_effect_count
    @move_effect_count = MOVE_EFFECT_FREQ +
                         @character.accele +
                         rand(MOVE_EFFECT_BUFFER)
  end

  # 一定回数タイルを動かしたらフィールドに何かアクションを起こす
  def move_effect
    @move_effect_count -= 1
    return if @move_effect_count > 0

    random_tile = available_tiles.sample
    random_tile.set_object(PBB::Bomb) if random_tile

    reset_move_effect_count
  end

  def move(touched_tile)
    # 触れたタイルと同じ行または列に空タイルがあるか
    if touched_tile.tx == @blank_tile.tx
      moved_tiles = vertical_move(touched_tile)
    elsif touched_tile.ty == @blank_tile.ty
      moved_tiles = horizontal_move(touched_tile)
    else
      moved_tiles = []
    end
    moved_tiles.each(&:moved_post_process)

    move_effect if moved_tiles.any?

    # タイル移動後のルートチェック
    #   * 現在の移動進路をハイライトする
    #   * ループしていないかのチェック
    check_routes(moved_tiles)
  end

  def horizontal_move(touched_tile)
    moved = []

    if touched_tile.tx > @blank_tile.tx
      dx = -1
      range = (@blank_tile.tx)..(touched_tile.tx)
    else
      dx = 1
      range = (touched_tile.tx)..(@blank_tile.tx)
    end

    @blank_tile.tx = touched_tile.tx
    @tiles.each do |tile|
      next if (tile == @blank_tile) ||
              (tile.ty != @blank_tile.ty) ||
              !range.include?(tile.tx)
      tile.tx = tile.tx + dx
      moved << tile
    end

    moved
  end

  def vertical_move(touched_tile)
    moved = []

    if touched_tile.ty > @blank_tile.ty
      dy = -1
      range = (@blank_tile.ty)..(touched_tile.ty)
    else
      dy = 1
      range = (touched_tile.ty)..(@blank_tile.ty)
    end

    @blank_tile.ty = touched_tile.ty
    @tiles.each do |tile|
      next if (tile == @blank_tile) ||
              (tile.tx != @blank_tile.tx) ||
              !range.include?(tile.ty)
      tile.ty = tile.ty + dy
      moved << tile
    end

    moved
  end

  def select_tile(tx, ty)
    @tiles.find { |t| t.tx == tx && t.ty == ty }
  end

  def check_routes(moved_tiles = [])
    PBB::Logger.debug "route check start:"
    start = @character.current_tile
    PBB::Logger.debug "->#{start.from}(#{start.tx}, #{start.ty})#{start.out}"
    @current_routes = [start]
    current = start
    current_from = current.from
    current_out = current.out
    while
      next_tile = current.next_tile(current_from)
      break if next_tile.is_a?(PBB::BlankTile) || next_tile.nil?
      PBB::Logger.debug "->#{current_from}"\
                        "[#{next_tile.class.name}(#{next_tile.tx}, #{next_tile.ty})]"\
                        "#{current_out}->"
      current_from = PBB::Character::OUTLET_TO_INLET[current_out]
      current_out = next_tile.class.routes[current_from]
      break if current_routes_loop_check(next_tile, moved_tiles)
      @current_routes << next_tile if current_out
      current = next_tile
    end

    @tiles.each do |t|
      if @current_routes.include?(t)
        t.highlight
      else
        t.highlight(false)
      end
    end
  end

  def current_routes_loop_check(next_tile, moved_tiles)
    prev_tile = @current_routes.last

    looping = false
    @current_routes.each_cons(2).each do |a, b|
      looping = (a == prev_tile && b == next_tile)
      if looping
        # ループを構成するタイルが今回動かされたものだった場合、
        # すなわち、今初めてループができた場合、ペナルティを課す
        loop_penalty if @current_routes.find { |r| moved_tiles.include?(r) }
        break
      end
    end

    looping
  end

  def loop_penalty
    PBB::Logger.debug "loop penalty!"
    @scene.activate_loop_effect
    tile = (@current_routes - [@character.current_tile]).select(&:no_object?).sample
    tile ||= available_tiles.sample
    tile.set_object(PBB::Bomb)
  end

  # 現在キャラクターやオブジェクトが乗っていない、blankでないタイルを返す
  def available_tiles
    (@tiles - [@character.current_tile, @blank_tile]).select(&:no_object?)
  end
end
