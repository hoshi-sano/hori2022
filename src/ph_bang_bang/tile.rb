# フィールドに並ぶタイルを表現するクラス
class PhBangBang::Tile < PhBangBang::Sprite
  WIDTH = 80
  HEIGHT = 80
  H_W = WIDTH / 2
  H_H = HEIGHT / 2
  LINE_W = 2
  X_SPEED = WIDTH / 4
  Y_SPEED = HEIGHT / 4
  PI = Math::PI

  attr_reader :tx, :ty, :from, :out

  class << self
    attr_reader :routes, :inlets, :destinations

    def define_routes(routes)
      @inlets = routes.keys
      @outlets = routes.values
      symbols = @inlets | @outlets
      raise "invalid inlet/outlet exists: #{symbols}" unless (symbols - %i[L R U D]).empty?
      @routes = routes
    end

    # 基本的には :L_R, :L_U, :D_L, :U_D, :U_R, :R_D のみ定義するものとする
    def define_destinations(destinations)
      @destinations = destinations
    end

    def rad(degree)
      degree * PI / 180
    end

    def image
      raise NotImplementedError
    end

    def highlight_image
      raise NotImplementedError
    end
  end

  def initialize(x, y, field)
    super(field.x + x * WIDTH, field.y + y * HEIGHT, self.class.image)
    @tx = x
    @ty = y
    @field = field
    @moving = false
    @dest_x = nil
    @dest_y = nil
    @from = nil
    @out = nil
    @destinations = nil
  end

  def tx=(next_x)
    @tx = next_x
    @moving = true
    @dest_x = @field.x + @tx * WIDTH
  end

  def ty=(next_y)
    @ty = next_y
    @moving = true
    @dest_y = @field.y + @ty * HEIGHT
  end

  def update
    super
    update_x
    update_y
  end

  def update_x
    return unless (@moving && @dest_x)
    d = self.x > @dest_x ? -1 : 1
    self.x += d * X_SPEED
    if self.x == @dest_x
      @dest_x = nil
      @moving = false
    end
  end

  def update_y
    return unless (@moving && @dest_y)
    d = self.y > @dest_y ? -1 : 1
    self.y += d * Y_SPEED
    if self.y == @dest_y
      @dest_y = nil
      @moving = false
    end
  end

  def hit(other)
    return if @moving
    return unless other.is_a?(PBB::TouchCircle)
    @field.move(self)
  end

  def enter(from)
    from ||= self.class.inlets.first
    PBB::Logger.debug "ENTER (#{@tx}, #{@ty})"
    PBB::Logger.debug "  - from:#{from}"
    unless self.class.inlets.include?(from)
      PBB.current_scene.game_over!
    end
    @from = from
    @out = self.class.routes[@from]
    PBB::Logger.debug "  - out:#{@out}"
    @destinations = select_destinations.dup
  end

  def select_destinations
    key = :"#{@from}_#{@out}"
    return self.class.destinations[key] if self.class.destinations.key?(key)
    reverse_key = "#{@out}_#{@from}"
    return self.class.destinations[reverse_key].reverse if self.class.destinations.key?(reverse_key)
    raise "invalid enter route, class:#{self.class}, from: #{@from}, out: #{@out}"
  end

  def next_xy
    return if @destinations.empty?
    dx, dy = @destinations.shift
    [self.x + dx, self.y + dy]
  end

  def next_tile(inlet = nil)
    outlet = inlet ? self.class.routes[inlet] : @out
    next_tx, next_ty = case outlet
                       when :U
                         [@tx, @ty - 1]
                       when :D
                         [@tx, @ty + 1]
                       when :L
                         [@tx - 1, @ty]
                       when :R
                         [@tx + 1, @ty]
                       end
    PBB::Logger.debug "calc next_tile: ->#{inlet || @from}(#{@tx}, #{@ty})#{outlet}-> "\
                      "to (#{next_tx}, #{next_ty})"
    @field.select_tile(next_tx, next_ty)
  end

  def highlight(activate = true)
    if activate
      PBB::Logger.debug "highlight tile: (#{@tx}, #{@ty})"
      self.image = self.class.highlight_image
    else
      self.image = self.class.image
    end
  end
end
