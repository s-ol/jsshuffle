require 'test/unit'
require 'jsshuffle'
require 'execjs'

class ParameterRenamingTest < Test::Unit::TestCase
    def test_can_include
        assert_nothing_raised do
            @shuffler = JsShuffle::Shuffler.new use: :parameter_renaming
        end
    end
end
