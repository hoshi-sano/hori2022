# タイトルシーン管理用クラス
class PhBangBang::TitleScene < PhBangBang::BaseScene
  BG = PBB::Sprite.new(0, 0, Image.new(Window.width, Window.height, [200, 200, 200])).
         tap { |bg| bg.collision_enable = false }
  TITLE_IMAGE = Image.new(350, 100, C_WHITE).tap { |img|
    img.draw_font(75, 30, "Ph Bang Bang !!", Font.default, C_BLACK)
  }
  TITLE_SPRITE = PBB::Sprite.new(50, 50, TITLE_IMAGE)
  START_IMAGE = Image.new(350, 100, C_WHITE).tap { |img|
    img.draw_font(135, 30, "START", Font.default, C_BLACK)
  }
  STORY_IMAGE = Image.new(350, 100, C_WHITE).tap { |img|
    img.draw_font(135, 30, "STORY", Font.default, C_BLACK)
  }
  CREDIT_IMAGE = Image.new(350, 100, C_WHITE).tap { |img|
    img.draw_font(135, 30, "CREDIT", Font.default, C_BLACK)
  }

  def generate_components
    super
    @defence_components << BG
    @defence_components << TITLE_SPRITE
    @defence_components << PBB::SceneChangeButton.new(50, 450, START_IMAGE, self, PBB::GameScene)
    @defence_components << PBB::SceneChangeButton.new(50, 560, STORY_IMAGE, self, PBB::SlideScene, :story)
    @defence_components << PBB::SceneChangeButton.new(50, 670, CREDIT_IMAGE, self, PBB::SlideScene, :credit)
  end

  def scene_changed
    DXOpal::Sound[:title].loop_play
  end

  def finalize
    DXOpal::Sound[:title].stop
    super
  end
end
