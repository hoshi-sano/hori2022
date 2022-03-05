# 進行早送り用ボタンのクラス
class PhBangBang::SpeedupButton < PhBangBang::Sprite
  def initialize(x = 0, y = 0, image = nil, character)
    super(x, y, image)
    @character = character
    @on = false
  end

  def hit
    if @on
      @on = false
      @character.tmp_speed = nil
    else
      @on = true
      @character.tmp_speed = 1
    end
  end
end
