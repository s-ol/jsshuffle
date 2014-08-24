module JsShuffle::Methods
    # Replaces local variable names with a randomly generated new one
    #
    # pass +:parameter_renaming+ in the +:use+ array of a {Parser}[rdoc-ref:JsShuffle::Parser] to use this +Method+.
    class ParameterRenaming < Method
        JsShuffle::Methods.methods[:parameter_renaming] = self

        def process( ast, shuffler )
            functionNodes = ast.select do |node| node.is_a? RKelly::Nodes::FunctionDeclNode end
            functionNodes.each do |node|
                renamed_parameters = {}
                node.arguments.each do |arg| renamed_parameters[arg.value] = (arg.value = shuffler.random_new_name) end
                node.function_body.value.each do |child|
                    child.value = renamed_parameters[child.value] if child.is_a? RKelly::Nodes::ResolveNode and renamed_parameters.has_key? child.value
                end
            end
        end
    end
end
