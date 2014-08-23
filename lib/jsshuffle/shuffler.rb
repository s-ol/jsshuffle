module JsShuffle

    # Shuffles a js-program or {RKelly AST}[rdoc-ref:RKelly::Nodes]
    # rdoc-ref:RDoc::Markup
    class Shuffler
        # Instantiate a new {Shuffler}[rdoc-ref:JsShuffle::Shuffler]
        # Parameters:
        # +use+::
        #   A +Symbol+, +Proc+ or a +Class+ inheriting from {JsShuffle::Methods::Method}[rdoc-ref:JsShuffle::Methods::Method] or an +Array+ mixing any of these types.
        #   Symbols are matched to JsShuffle's native {Methods}[rdoc-ref:JsShuffle::Methods] and should be lowercased and underscored (like the filenames of the corresponding +Method+)
        #   Procs are called three times and receive the +pass+ (one of +:preprocess+, +:process+ or +postprocess+), the AST and the {Shuffler}[rdoc-ref:JsShuffle::Shuffler] instance. In the last pass the js string is passed instead of the AST and the Proc is expected to return the modified string
        def initialize( hash={ use: :variable_renaming } )
            @methods = hash[:use]
            @methods = [ @methods ] if @methods.is_a? Symbol

            @parser = RKelly::Parser.new

            @methods.collect! do |m|
                next (JsShuffle::Methods.methods[m]).new if m.is_a? Symbol 
                next m.new if m.is_a? JsShuffle::Methods::Method
                m
            end

            @defaults = {}
            @methods.each do |m|
                @defaults.merge! m.default_config if m.is_a? JsShuffle::Methods::Method
            end
        end

        # Shuffle a javascript program string and return the result
        #
        # Used to make {Shuffler}[rdoc-ref:JsShuffle::Shuffler] available as a +Rails+ JS Preprocessor
        #
        # Parameters:
        # +source+::
        #   The js source string
        def compress( source )
            shuffle js: source
        end

        # Shuffle a js-string or a {RKelly AST}[rdoc-ref:RKelly::Nodes]
        #
        # Parameters:
        # +options+::
        #   an option hash containing either
        #   +js+::  the javascript source code as a string _or_
        #   +ast+:: the parsed javascript source as {RKelly AST}[rdoc-ref:RKelly::Nodes]
        #   and optionally the following options:
        #   +output+::  the output format, +:string+ or +:ast+
        #
        #   all other options are passed on to the {Methods}[rdoc-ref:JsShuffle::Methods] supplied during initialization
        # 
        # Returns either a +String+ or {RKelly AST}[rdoc-ref:Rkelly::Nodes], matching the input format or the +output+ value
        def shuffle( hash={} )
            hash = { js: hash } if hash.is_a? String
            options = @defaults.merge(hash) 
            @new_names = []
            ast = hash[:ast] || @parser.parse( hash[:js] )

            @methods.each do |m| m.configure options if m.is_a? JsShuffle::Methods::Method end

            [:preprocess, :process].each do |pass|
                @methods.each do |m|
                    next m.send( pass, ast, self ) if m.is_a? JsShuffle::Methods::Method and m.respond_to? pass
                    m.call( pass, ast, self ) if m.respond_to? :call
                end
            end
            js = ast.to_ecma
            @methods.each do |m|
                next (js = m.postprocess( ast, self )) if m.is_a? JsShuffle::Methods::Method and m.respond_to? :postprocess
                js = m.call( :postprocess, js, self ) if m.respond_to? :call
            end

            if hash.has_key? :output
                return js if hash[:output] == :string
                return @parser.parse( js )
            end

            return @parser.parse( js ) if hash[:ast]
            js
        end
        
        # Generates a random new symbol name
        def random_new_name
            begin
                new_name = ('a'..'z').to_a.shuffle[0,8].join
            end while @new_names.include? new_name
            new_name
        end
    end
end
