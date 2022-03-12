# ゲーム中の得点の記録と表示を担うクラス
class PhBangBang::ScoreBoard < PhBangBang::Sprite
  STR_FORMAT = 'SCORE: %010d'
  LEVEL_MAP = {
    2 => 1000,
    3 => 5000,
    4 => 10000,
    5 => 20000,
    6 => 30000,
    7 => 50000,
    8 => 70000,
    9 => 90000,
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
    case @current_level
    when 1, 2, 3
      DXOpal::Sound[:cheer_1].play
    when 4, 5, 6
      DXOpal::Sound[:cheer_2].play
    when 7, 8, 9
      DXOpal::Sound[:cheer_3].play
    end
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
