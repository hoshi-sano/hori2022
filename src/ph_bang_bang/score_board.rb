# ゲーム中の得点の記録と表示を担うクラス
class PhBangBang::ScoreBoard < PhBangBang::Sprite
  IMAGE = Image.new(300, 50, C_BLACK)
  STR_FORMAT = 'SCORE: %010d'

  attr_accessor :score

  def initialize(x, y, score = 0)
    super(x, y, IMAGE)
    @score = score
  end

  def score_str
    sprintf(STR_FORMAT, @score)
  end

  def draw
    super
    DXOpal::Window.draw_font(self.x, self.y, score_str, Font.default)
  end
end
