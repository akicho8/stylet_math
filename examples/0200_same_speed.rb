# -*- coding: utf-8 -*-
#
# 円の移動の定石
#
require File.expand_path(File.join(File.dirname(__FILE__), "helper"))

class Scene
  def initialize(win)
    @win = win

    @pA = @win.srect.center.clone
    @sA = Stylet::Vector.sincos(Stylet::Fee.clock(8))
    @rect = Stylet::Rect.circle_like(50)

    @radius = 50
    @vertex = 32
    @gravity = 32
  end

  def update
    # 操作
    begin
      # AとBで速度ベクトルの反映
      @pA += @sA.scale(@win.button.btA.repeat_0or1) + @sA.scale(-@win.button.btB.repeat_0or1)

      # 外に出てしまったらスピード反転

      # @win.vputs Stylet::CollisionSupport.rect_include?(@win.srect, @rect.add_vector(@pA)).inspect
      unless Stylet::CollisionSupport.rect_include?(@win.srect, @rect.add_vector(@pA))
        @sA = @sA * -1
      end

      # Cボタンおしっぱなし + マウスで自機位置移動
      if @win.button.btC.press?
        @pA = @win.cursor.clone
      end
      # Dボタンおしっぱなし + マウスで自機角度変更
      if @win.button.btD.press?
        if @win.cursor != @pA
          @sA = (@win.cursor - @pA).normalize * @sA.radius
        end
      end
    end

    if @mode == "mode1"
    end

    @win.draw_rect2(@win.srect)
    @win.draw_rect2(@rect.add_vector(@pA))
    @win.draw_vector(@sA.scale(@radius / 2), :origin => @pA)
  end
end

class App < Stylet::Base
  include Helper::TriangleCursor

  attr_reader :mode

  def before_main_loop
    super if defined? super
    @cursor_vertex = 3

    @modes = ["mode1", "mode2", "mode3"]
    @mode = @modes.first
    @objects << Scene.new(self)
  end

  def update
    super if defined? super
    if key_down?(SDL::Key::S)
      @mode = @modes[@modes.index(@mode).next.modulo(@modes.size)]
    end
  end
end

App.main_loop