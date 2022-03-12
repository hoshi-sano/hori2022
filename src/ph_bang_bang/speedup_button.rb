# 進行早送り用ボタンのクラス
class PhBangBang::SpeedupButton < PhBangBang::Sprite
  attr_accessor :pair

  def initialize(x, y, character, other = nil)
    super(x, y, DXOpal::Image[:speedup_button])
    @character = character
    @on = false
    if other
      @pair = other
      other.pair = self
    end
  end

  def turn_off
    @on = false
    self.image = DXOpal::Image[:speedup_button]
  end

  def turn_on
    @on = true
    self.image = DXOpal::Image[:speedup_button_HL]
  end

  def hit
    if @on
      turn_off
      @pair.turn_off
      @character.tmp_speed = nil
    else
      turn_on
      @pair.turn_on
      @character.tmp_speed = 1
    end
  end
end
