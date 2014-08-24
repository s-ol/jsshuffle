jsshuffle ![Gem Version](https://badge.fury.io/rb/jsshuffle.svg)
================================================================

A library to just-in-time randomly obfuscate JS. 


Installation
------------

    $ gem install jsshuffle

and 

    require 'jsshuffle'

should be enough to get you up and running.

For rails, just add _jsshuffle_ to your Gemfile:

    gem 'jsshuffle', group: :production


Usage
-----

_jsshuffle_ can be used standalone and as a Ruby library.

The standalone executable takes a filename as a parameter or reads the input from `STDIN` and outputs on `STDOUT`:

    $ jsshuffle <<EOF
    > var test = 13;
    > test = (test + 13) * 7;
    > alert( test );
    > EOF
    var dqkwxnvj = 13;
    dqkwxnvj = (dqkwxnvj + 13) * 7;
    alert(dqkwxnvj);

To use _jsshuffle_ in your own Ruby project, instantiate `JsShuffle::Shuffler`:

    require 'jsshuffle'

    shuffler = JsShuffle::Shuffler.new use: :variable_renaming

    puts shuffler.shuffle js: %Q(
        var variable = "variable";
        function newFunc( parameter ) {
            return parameter + " is a cool parameter.";
        }

        console.log( newFunc( variable ) );
    )

Extending JsShuffle
-------------------

You can sublcass `JsShuffle::Methods::Method` and pass the new class as a `use:` argument to `Shuffler#new` or alternatively pass a Block or Proc.  
For more information view the RDoc.
