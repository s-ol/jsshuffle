require 'test/unit'
require 'jsshuffle'
require 'execjs'

class VariableRenamingTest < Test::Unit::TestCase
    def setup
        @shuffler = JsShuffle::Shuffler.new use: :variable_renaming
    end

    def test_name_changes
        original = "var beers_i_had = 5;"
        assert_not_equal original,
            @shuffler.shuffle( js: original )
    end

    def test_references_updated
        assert_no_match /is_working/,
            @shuffler.shuffle( js: %Q(
                var is_working = true;
                return is_working;
            ))
    end

    def test_code_works
        shuffled = @shuffler.shuffle js: %Q(
            var twelve = 12;
            twelve = twelve + 2;
            return twelve;
        )

        assert_equal 14,
            ExecJS.exec( shuffled )
    end
end
