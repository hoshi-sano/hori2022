# スライドシーン管理用クラス
class PhBangBang::SlideScene < PhBangBang::BaseScene
  SLIDE = {
    story: [
      Image.new(Window.width, Window.height, [50, 50, 50]),
      Image.new(Window.width, Window.height, [100, 100, 100]),
      Image.new(Window.width, Window.height, [150, 150, 150]),
      Image.new(Window.width, Window.height, [200, 200, 200]),
    ],
    credit: [
      Image.new(Window.width, Window.height, [100, 100, 100]),
    ],
  }
  LEFT_BUTTON_IMAGE = Image.new(Window.width / 2, Window.height - 50, C_BLUE)
  RIGHT_BUTTON_IMAGE = Image.new(Window.width / 2, Window.height - 50, C_RED)

  def initialize(type)
    @slides = SLIDE[type]
    super(nil)
    @index = 0
    update_buttons
  end

  def generate_components
    @current_slide = PBB::Sprite.new(0, 0, @slides[0])
    @prev_button = PBB::SlideChangeButton.new(0, 50, LEFT_BUTTON_IMAGE, self, :prev)
    @next_button = PBB::SlideChangeButton.new(Window.width / 2, 50, RIGHT_BUTTON_IMAGE, self, :next)
    @defence_components << @current_slide
    @defence_components << @prev_button
    @defence_components << @next_button
  end

  def update_buttons
    if @index == 0
      @prev_button.collision_enable = false
      @prev_button.visible = false
    else
      @prev_button.collision_enable = true
      @prev_button.visible = true
    end
  end

  def next_slide
    @index += 1
    unless @slides[@index]
      change_scene(PBB::TitleScene)
      return
    end
    @current_slide.image = @slides[@index]
    update_buttons
  end

  def prev_slide
    @index -= 1
    @current_slide.image = @slides[@index]
    update_buttons
  end
end

class PhBangBang::SlideChangeButton < PhBangBang::Sprite
  def initialize(x, y, image, slide_scene, direction)
    super(x, y, image)
    @slide_scene = slide_scene
    @direction = direction
  end

  def hit
    case @direction
    when :prev
      @slide_scene.prev_slide
    when :next
      @slide_scene.next_slide
    end
  end
end
