# キャラクターのエネルギー状態を表示するためのクラス
# エネルギー状態はキャラクターの加速状態と同義
class PhBangBang::EnergyGage < PhBangBang::Sprite
  BG_IMAGE = Image.new(310, 60, C_BLACK)
  GAGE_UNIT_IMAGE = Image.new(30, 50, [100, 100, 0]).tap { |img|
    img.box_fill(1, 1, 29, 49, [200, 200, 0])
  }
  OFFSET_X = 5
  OFFSET_Y = 5

  def initialize(character)
    super(75, 650, BG_IMAGE)
    @character = character
    @character.energy_gage = self
    @gage = (0..9).map { |n|
      PBB::Sprite.new(self.x + OFFSET_X + n * 30, self.y + OFFSET_Y, GAGE_UNIT_IMAGE)
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
