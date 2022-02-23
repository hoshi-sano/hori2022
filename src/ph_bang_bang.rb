module PhBangBang
  class << self
    def init
      @current_scene = TitleScene.new
    end

    def run
      init

      Window.load_resources do
        Window.loop do
          @current_scene.play
        end
      end
    end

    def change_scene(next_scene_class)
      @current_scene = next_scene_class.new
    end
  end
end
PBB = PhBangBang # shortcut

require_remote "src/ph_bang_bang/sprite.rb"
require_remote "src/ph_bang_bang/touch_circle.rb"
require_remote "src/ph_bang_bang/input.rb"
require_remote "src/ph_bang_bang/base_scene.rb"
require_remote "src/ph_bang_bang/title_scene.rb"
require_remote "src/ph_bang_bang/game_scene.rb"
require_remote "src/ph_bang_bang/scene_change_button.rb"
require_remote "src/ph_bang_bang/tile.rb"
require_remote "src/ph_bang_bang/field.rb"
