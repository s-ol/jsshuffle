require 'test/unit'
require 'jsshuffle'
require 'execjs'

class ShufflerTest < Test::Unit::TestCase
    def test_instantiate
        assert_nothing_raised do
            @shuffler = JsShuffle::Shuffler.new
        end
    end

    def test_default_does_something
        assert_nothing_raised { @shuffler = JsShuffle::Shuffler.new }
        original = "var beers_i_had = 5; return beers_i_had;"
        shuffled = @shuffler.shuffle js: original

        assert_not_equal original, shuffled

        assert_equal 5,
            ExecJS.exec( shuffled )
    end

    def test_code_works
        assert_nothing_raised { @shuffler = JsShuffle::Shuffler.new }
        shuffled = @shuffler.shuffle js: %Q(
            var twelve = 12;
            twelve = twelve + 2;
            function subtract_three( number ) {
                var local = number - 3;
                return local;
            }
            return subtract_three( twelve ) + "-ish";
        )

        assert_equal "11-ish",
            ExecJS.exec( shuffled )
    end
end
