require 'dxopal'
include DXOpal

Window.width = 450
Window.height = 800
Window.bgcolor = C_BLACK

CENTER_X = Window.width / 2
CENTER_Y = Window.height / 2

require_remote "src/ph_bang_bang.rb"

PhBangBang.run
