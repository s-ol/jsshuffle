module JsShuffle::Methods

    # Wraps up a +Method+ to obfuscate / shuffle the JS.
    # 
    # When subclassing +Method+ define one or more of the three processing hooks:
    # +preprocess+::    called in the first pass, this hook shouldn't modify the AST
    # +process+::       called as the second pass. Modify the AST here
    # +postprocess+::   called last. This method gets passed the js in string form and is expected to return a string itself
    class Method
        # Returns the hash of default options the +Method+ accepts in the {configure}[rdoc-ref:JsShuffle::Methods::method#configure] method
        def default_config
            return {}
        end

        # Configures the +Method+ instance given the option hash
        # 
        # Parameters:
        # +options+:: The options hash
        def configure( options )
            @options = options
        end

        # Called in the first pass. Don't modify the AST in here!
        #
        # Parameters:
        # +ast+::       The JS AST
        # +shuffler::   The {Shuffler}[rdoc-ref:JsShuffle::Shuffler] calling the hook
        def preprocess( ast, shuffler )
        end

        # Called in the second pass. Modify the AST here
        #
        # Parameters:
        # +js+::        The JS AST
        # +shuffler::   The {Shuffler}[rdoc-ref:JsShuffle::Shuffler] calling the hook
        def process( ast, shuffler )
        end

        # Called last of the three hooks. Return the js!
        #
        # Parameters:
        # +js+::        The JS in string form
        # +shuffler::   The {Shuffler}[rdoc-ref:JsShuffle::Shuffler] calling the hook
        def postprocess( js, shuffler )
            js
        end
        
        # Make sure +#respond_to?+ works like expected, even though this class provides the hooks
        def self.inherited( subclass )
            undef_method :preprocess    rescue ""
            undef_method :process       rescue "" 
            undef_method :postprocess   rescue ""
            super
        end
    end
end
