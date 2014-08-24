module JsShuffle
    module Methods
        class << self
            attr_accessor :methods
        end
    end
    Methods.methods = {}
end

require 'jsshuffle/methods/method.rb'
require 'jsshuffle/methods/variable_renaming.rb'
require 'jsshuffle/methods/parameter_renaming.rb'
