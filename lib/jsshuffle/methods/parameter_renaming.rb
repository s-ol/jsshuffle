module JsShuffle::Methods
    # Replaces local variable names with a randomly generated new one
    #
    # pass +:parameter_renaming+ in the +:use+ array of a {Parser}[rdoc-ref:JsShuffle::Parser] to use this +Method+.
    class ParameterRenaming < Method
        JsShuffle::Methods.methods[:parameter_renaming] = self
    end
end
