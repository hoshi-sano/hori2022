# タイルが並ぶフィールドを表現するクラス
class PhBangBang::Field < PhBangBang::Sprite
  attr_reader :tiles

  IMAGE = Image.new(400, 400, C_WHITE)

  def initialize
    x = CENTER_X - (IMAGE.width / 2)
    y = CENTER_Y - (IMAGE.height / 2)
    super(x, y, IMAGE)
    self.collision_enable = false

    @tiles = [
      PBB::HTile.new(0, 0, self),
      PBB::HTile.new(1, 0, self),
      PBB::VTile.new(2, 0, self),
      PBB::VTile.new(3, 0, self),
      PBB::HVTile.new(4, 0, self),
      PBB::HVTile.new(0, 1, self),
      PBB::HVTile.new(1, 1, self),
      PBB::HVTile.new(2, 1, self),
      PBB::LDRUTile.new(3, 1, self),
      PBB::LDRUTile.new(4, 1, self),
      PBB::LDRUTile.new(0, 2, self),
      PBB::LDRUTile.new(1, 2, self),
      PBB::LDTile.new(2, 2, self),
      PBB::LDTile.new(3, 2, self),
      PBB::RUTile.new(4, 2, self),
      PBB::RUTile.new(0, 3, self),
      PBB::LURDTile.new(1, 3, self),
      PBB::LURDTile.new(2, 3, self),
      PBB::LURDTile.new(3, 3, self),
      PBB::LURDTile.new(4, 3, self),
      PBB::LUTile.new(0, 4, self),
      PBB::LUTile.new(1, 4, self),
      PBB::RDTile.new(2, 4, self),
      PBB::RDTile.new(3, 4, self),
    ]
    @blank_tile = PBB::BlankTile.new(4, 4, self)
    @tiles << @blank_tile
    @tiles.shuffle!
  end

  def move(touched_tile)
    # 触れたタイルと同じ行または列に空タイルがあるか
    if touched_tile.tx == @blank_tile.tx
      vertical_move(touched_tile)
    elsif touched_tile.ty == @blank_tile.ty
      horizontal_move(touched_tile)
    end
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
end
