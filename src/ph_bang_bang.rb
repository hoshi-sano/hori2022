module PhBangBang
  class << self
    def init
      DXOpal::Sound.register(:title, "sounds/title.mp3")
      @current_scene = CreditScene.new
    end

    def current_scene
      @current_scene
    end

    def run
      init

      Window.load_resources do
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

require_remote "src/monkey_patches/001_enable_sound_loop.rb"
require_remote "src/ph_bang_bang/logger.rb"
require_remote "src/ph_bang_bang/sprite.rb"
require_remote "src/ph_bang_bang/touch_circle.rb"
require_remote "src/ph_bang_bang/input.rb"
require_remote "src/ph_bang_bang/base_scene.rb"
require_remote "src/ph_bang_bang/credit_scene.rb"
require_remote "src/ph_bang_bang/title_scene.rb"
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
require_remote "src/ph_bang_bang/score_board.rb"
require_remote "src/ph_bang_bang/game_over_effect.rb"
