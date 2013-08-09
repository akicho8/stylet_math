# -*- coding: utf-8 -*-

module Stylet
  module Pause
    attr_accessor :pause

    def initialize
      super
      @pause = Info.new
      @pause.enable = false
      @pause.keys ||= [SDL::Key::P, SDL::Key::SPACE, SDL::Key::RETURN]
    end

    def polling
      super
      if @pause.keys.any?{|key|key_down?(key)}
        @pause.toggle
      end
    end

    def pause?
      @pause.enable
    end

    class Info
      attr_accessor :enable, :keys

      def toggle
        self.enable = !enable
      end
    end
  end
end

if $0 == __FILE__
  require_relative "../stylet"
  Stylet.run
end
