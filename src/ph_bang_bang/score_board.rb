# ゲーム中の得点の記録と表示を担うクラス
class PhBangBang::ScoreBoard < PhBangBang::Sprite
  STR_FORMAT = 'SCORE: %010d'
  LEVEL_MAP = {
    2 => 1000,
    3 => 5000,
    4 => 10000,
    5 => 20000,
    6 => 50000,
    7 => 100000,
    8 => 200000,
    9 => 300000,
  }
  OFFSET_X = 15
  OFFSET_Y = 15

  attr_accessor :score

  def initialize(x, y, character, score = 0)
    super(x, y, DXOpal::Image[:score_board])
    @character = character
    @score = score
    @current_level = 1
  end

  def score=(v)
    @score = v
    level_up if @score >= (LEVEL_MAP[@current_level + 1] || Float::INFINITY)
  end

  def level_up
    @current_level += 1
    @character.speed_up!
  end

  def score_str
    sprintf(STR_FORMAT, @score)
  end

  def draw
    super
    DXOpal::Window.draw_font(self.x + OFFSET_X,
                             self.y + OFFSET_Y,
                             score_str,
                             Font.default)
  end
end
