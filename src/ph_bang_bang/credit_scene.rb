# タイトルより前に表示するシーンの管理用クラス
# ブラウザの制限により最初に表示される画面でオート再生のBGMを鳴らすことができず、
# 初回タイトル画面のBGMが鳴らないため、この画面をワンクッションを挟む。
class PhBangBang::CreditScene < PhBangBang::BaseScene
  BG = PBB::Sprite.new(0, 0, Image.new(Window.width, Window.height, [0, 0, 0]))
  CREDIT_IMAGE = Image.new(350, 100, [50, 50, 50]).tap { |img|
    img.draw_font(75, 30, "PLEASE TOUCH", Font.default, C_WHITE)
  }
  CREDIT_SPRITE = PBB::Sprite.new(50, 50, CREDIT_IMAGE)

  def generate_components
    super
    @defence_components << BG
    @defence_components << CREDIT_SPRITE
  end

  def check_keys
    change_scene(PBB::TitleScene) if PBB::Input.mouse_push? || PBB::Input.touch?
  end
end
