require 'dxopal'
include DXOpal

Window.width = 450
Window.height = 800
Window.bgcolor = C_BLACK

require_remote "src/hori2022.rb"

Hori2022.run
