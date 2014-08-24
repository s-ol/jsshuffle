module JsShuffle::Methods
    # Replaces local variable names with a randomly generated new one
    #
    # pass +:parameter_renaming+ in the +:use+ array of a {Parser}[rdoc-ref:JsShuffle::Parser] to use this +Method+.
    class ParameterRenaming < Method
        JsShuffle::Methods.methods[:parameter_renaming] = self

        def process( ast, shuffler )
            functionNodes = ast.select { |node| node.is_a? RKelly::Nodes::FunctionDeclNode }
            functionNodes.each do |node|
                renamed_parameters = {}
                node.arguments.each { |arg| renamed_parameters[arg.value] = (arg.value = shuffler.random_new_name) }
                node.function_body.value.each { |child| child.value = renamed_parameters[child.value] if child.is_a? RKelly::Nodes::ResolveNode and renamed_parameters.has_key? child.value }
            end
        end
    end
end
