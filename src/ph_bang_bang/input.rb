# 入力制御用モジュール
module PhBangBang
  module Input
    class << self
      def mouse_push?
        DXOpal::Input.mouse_push?(DXOpal::M_LBUTTON)
      end

      def mouse_xy
        [DXOpal::Input.mouse_x, DXOpal::Input.mouse_y]
      end

      def touch?
        DXOpal::Input.touch_push?
      end

      def new_touches
        DXOpal::Input.new_touches.each do |t|
          yield(t)
        end
      end
    end
  end
end
