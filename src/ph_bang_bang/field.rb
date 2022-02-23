# タイルが並ぶフィールドを表現するクラス
class PhBangBang::Field < PhBangBang::Sprite
  IMAGE = Image.new(400, 400, C_WHITE)

  def initialize
    x = CENTER_X - (IMAGE.width / 2)
    y = CENTER_Y - (IMAGE.height / 2)
    super(x, y, IMAGE)

    @tiles =[
      [0, 0], [1, 0], [2, 0], [3, 0], [4, 0],
      [0, 1], [1, 1], [2, 1], [3, 1], [4, 1],
      [0, 2], [1, 2], [2, 2], [3, 2], [4, 2],
      [0, 3], [1, 3], [2, 3], [3, 3], [4, 3],
      [0, 4], [1, 4], [2, 4], [3, 4], [4, 4],
    ].map { |tx, ty| PBB::Tile.new(tx, ty, self) }
  end

  def update
    super
    @tiles.each(&:update)
  end

  def draw
    super
    @tiles.each(&:draw)
  end

  def valished?
    super
  end
end
