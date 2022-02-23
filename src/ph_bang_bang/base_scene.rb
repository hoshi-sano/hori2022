# 各シーンクラスのベースとなるクラス
class PhBangBang::BaseScene
  def initialize
    @components = []
    generate_components
  end

  def generate_components
  end

  def play
    update_components
    draw_components
    check_keys
  end

  def update_components
    @components.each(&:update)
    @components.delete_if(&:vanished?)
  end

  def draw_components
    @components.each(&:draw)
  end

  def check_keys
    if PBB::Input.mouse_push?
      @components << PBB::TouchCircle.new(*PBB::Input.mouse_xy)
    end

    PBB::Input.new_touches do |t|
      @components << PBB::TouchCircle.new(t.x, t.y)
    end
  end
end
