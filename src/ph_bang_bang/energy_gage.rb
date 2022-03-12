# キャラクターのエネルギー状態を表示するためのクラス
# エネルギー状態はキャラクターの加速状態と同義
class PhBangBang::EnergyGage < PhBangBang::Sprite
  OFFSET_X = 50
  OFFSET_Y = 8

  def initialize(character)
    super(80, 620, DXOpal::Image[:energy_gage])
    @character = character
    @character.energy_gage = self
    @gage = (0..9).map { |n|
      PBB::Sprite.new(self.x + OFFSET_X + n * 22,
                      self.y + OFFSET_Y,
                      DXOpal::Image[:energy_gage_unit])
    }
    update_gage
  end

  def update_gage
    @gage.each_with_index do |g, idx|
      g.visible = (idx <= @character.tmp_accele)
    end
  end

  def draw
    super
    @gage.each(&:draw)
  end
end
