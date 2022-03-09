# 各シーンクラスのベースとなるクラス
class PhBangBang::BaseScene
  def initialize(arg1 = nil)
    @offence_components = []
    @defence_components = []
    generate_components
  end

  def generate_components
  end

  def play
    PBB.change_scene(@next_scene_class, @scene_change_arg1) if @finalized
    update_components
    draw_components
    check_keys
    check_collision
  end

  def update_components
    @offence_components.each(&:update)
    @defence_components.each(&:update)
    @offence_components.delete_if(&:vanished?)
    @defence_components.delete_if(&:vanished?)
  end

  def draw_components
    @defence_components.each(&:draw)
    @offence_components.each(&:draw)
  end

  def check_collision
    DXOpal::Sprite.check(@offence_components, @defence_components)
  end

  def check_keys
    if PBB::Input.mouse_push?
      @offence_components << PBB::TouchCircle.new(*PBB::Input.mouse_xy)
    end

    PBB::Input.new_touches do |t|
      @offence_components << PBB::TouchCircle.new(t.x, t.y)
    end
  end

  def change_scene(next_scene_class, arg1 = nil)
    @next_scene_class = next_scene_class
    @scene_change_arg1 = arg1
    finalize
  end

  # シーンチェンジの直後に1度だけ呼ばれるメソッド
  def scene_changed
  end

  def finalize
    @finalized = true
  end
end
