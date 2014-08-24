require 'test/unit'
require 'jsshuffle'
require 'execjs'

class ParameterRenamingTest < Test::Unit::TestCase
    def test_can_include
        assert_nothing_raised do
            @shuffler = JsShuffle::Shuffler.new use: :parameter_renaming
        end
    end

    def test_name_changes
        assert_nothing_raised { @shuffler = JsShuffle::Shuffler.new use: :parameter_renaming }
        original = %Q(
            function double(parameter) {
                return parameter*2;
            }
        )
        assert_not_equal original,
            @shuffler.shuffle( js: original )
    end

    def test_code_works
        assert_nothing_raised { @shuffler = JsShuffle::Shuffler.new use: :parameter_renaming }
        shuffled = @shuffler.shuffle js: %Q(
            function double(parameter) {
                return parameter*2;
            }
            return double(333);
        )
        assert_equal 666,
            ExecJS.exec( shuffled )
    end

    def test_references_updated
        assert_nothing_raised { @shuffler = JsShuffle::Shuffler.new use: :parameter_renaming }
        assert_no_match /parameter/,
            @shuffler.shuffle( js: %Q(
                function double(parameter) {
                    return parameter*2;
                }
                return double(333);
            ))
    end
end
