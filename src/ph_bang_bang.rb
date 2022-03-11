module PhBangBang
  class << self
    def init
      @current_scene = CreditScene.new
    end

    def current_scene
      @current_scene
    end

    def run
      Window.load_resources do
        init
        Window.loop do
          @current_scene.play
        end
      end
    end

    def change_scene(next_scene_class, arg1 = nil)
      @current_scene = next_scene_class.new(arg1)
      @current_scene.scene_changed
    end
  end
end
PBB = PhBangBang # shortcut

DXOpal::Sound.register(:title, "sounds/title.mp3")
[
  :back_button,
  :bomb_01,
  :bomb_02,
  :bomb_03,
  :energy_gage,
  :energy_gage_unit,
  :game_bg,
  :h_tile,
  :h_tile_HL,
  :h_v_tile,
  :h_v_tile_HL,
  :l_d_r_u_tile,
  :l_d_r_u_tile_HL,
  :l_d_tile,
  :l_d_tile_HL,
  :logo,
  :l_u_r_d_tile,
  :l_u_r_d_tile_HL,
  :l_u_tile,
  :l_u_tile_HL,
  :ph_01,
  :ph_02,
  :r_d_tile,
  :r_d_tile_HL,
  :r_u_tile,
  :r_u_tile_HL,
  :score_board,
  :speedup_button,
  :speedup_button_HL,
  :v_tile,
  :v_tile_HL,
].each do |key|
  DXOpal::Image.register(key, "images/#{key}.png")
end

require_remote "src/monkey_patches/001_enable_sound_loop.rb"
require_remote "src/ph_bang_bang/logger.rb"
require_remote "src/ph_bang_bang/sprite.rb"
require_remote "src/ph_bang_bang/touch_circle.rb"
require_remote "src/ph_bang_bang/input.rb"
require_remote "src/ph_bang_bang/base_scene.rb"
require_remote "src/ph_bang_bang/credit_scene.rb"
require_remote "src/ph_bang_bang/title_scene.rb"
require_remote "src/ph_bang_bang/slide_scene.rb"
require_remote "src/ph_bang_bang/game_scene.rb"
require_remote "src/ph_bang_bang/result_scene.rb"
require_remote "src/ph_bang_bang/scene_change_button.rb"
require_remote "src/ph_bang_bang/speedup_button.rb"
require_remote "src/ph_bang_bang/tile.rb"
require_remote "src/ph_bang_bang/blank_tile.rb"
require_remote "src/ph_bang_bang/h_tile.rb"
require_remote "src/ph_bang_bang/h_v_tile.rb"
require_remote "src/ph_bang_bang/l_d_r_u_tile.rb"
require_remote "src/ph_bang_bang/l_d_tile.rb"
require_remote "src/ph_bang_bang/l_u_r_d_tile.rb"
require_remote "src/ph_bang_bang/l_u_tile.rb"
require_remote "src/ph_bang_bang/r_d_tile.rb"
require_remote "src/ph_bang_bang/r_u_tile.rb"
require_remote "src/ph_bang_bang/v_tile.rb"
require_remote "src/ph_bang_bang/field.rb"
require_remote "src/ph_bang_bang/character.rb"
require_remote "src/ph_bang_bang/tile_object.rb"
require_remote "src/ph_bang_bang/bomb.rb"
require_remote "src/ph_bang_bang/score_board.rb"
require_remote "src/ph_bang_bang/game_over_effect.rb"
require_remote "src/ph_bang_bang/energy_gage.rb"
require_remote "src/ph_bang_bang/share_button.rb"
