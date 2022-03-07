# タイルが並ぶフィールドを表現するクラス
class PhBangBang::Field < PhBangBang::Sprite
  attr_reader :tiles
  attr_accessor :character

  WIDTH = 400
  HEIGHT = 400
  IMAGE = Image.new(WIDTH, HEIGHT, C_WHITE)
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

  def initialize
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

  def move(touched_tile)
    # 触れたタイルと同じ行または列に空タイルがあるか
    if touched_tile.tx == @blank_tile.tx
      vertical_move(touched_tile)
    elsif touched_tile.ty == @blank_tile.ty
      horizontal_move(touched_tile)
    end
    # タイル移動後のルートチェック
    #   * 現在の移動進路をハイライトする
    #   * ループしていないかのチェック
    check_routes
  end

  def horizontal_move(touched_tile)
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
    end
  end

  def vertical_move(touched_tile)
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
    end
  end

  def select_tile(tx, ty)
    @tiles.find { |t| t.tx == tx && t.ty == ty }
  end

  def check_routes
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
      PBB::Logger.debug "->#{current_from}(#{next_tile.tx}, #{next_tile.ty})#{current_out}->"
      current_from = PBB::Character::OUTLET_TO_INLET[current_out]
      current_out = next_tile.class.routes[current_from]
      # TODO: このあたりでループチェック
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
end
