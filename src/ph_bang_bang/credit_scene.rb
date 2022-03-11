# タイトルより前に表示するシーンの管理用クラス
# ブラウザの制限により最初に表示される画面でオート再生のBGMを鳴らすことができず、
# 初回タイトル画面のBGMが鳴らないため、この画面をワンクッションを挟む。
class PhBangBang::CreditScene < PhBangBang::BaseScene
  def generate_components
    super
    bg = PBB::Sprite.new(0, 0, DXOpal::Image[:logo])
    @defence_components << bg
  end

  def check_keys
    change_scene(PBB::TitleScene) if PBB::Input.mouse_push? || PBB::Input.touch?
  end
end
