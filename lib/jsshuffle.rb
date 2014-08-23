require 'rubygems'
require 'bundler/setup'

require 'rkelly'

require 'jsshuffle/version'
require 'jsshuffle/methods'
require 'jsshuffle/shuffler'

require 'jsshuffle/railtie' if defined?(Rails)
