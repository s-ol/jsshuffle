require 'rails'

module JsShuffle
    class Railtie < ::Rails::Railtie
        config.assets.js_compressor = Shuffler.new
    end
end
