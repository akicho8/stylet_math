# -*- coding: utf-8 -*-
# コードブロックを使ったストラテジー
require File.expand_path(File.join(File.dirname(__FILE__), "../lib/stylet"))
Stylet::Base.instance.main_loop do |base|
  base.gputs(SDL::Mouse.state.inspect)
end
