module JsShuffle::Methods
    # Replaces local variable names with a randomly generated new one
    #
    # pass +:variable_renaming+ in the +:use+ array of a {Parser}[rdoc-ref:JsShuffle::Parser] to use this +Method+.
    class VariableRenaming < Method
        JsShuffle::Methods.methods[:variable_renaming] = self

        def process( ast, shuffler )
            sourceNodes = ast.select { |node| node.is_a? RKelly::Nodes::SourceElementsNode }
            sourceNodes.each do |node|
                renamed_variables = {} 
                node.value.each do |child|
                    if child.is_a? RKelly::Nodes::VarStatementNode
                        renamed_variables[child.value.first.name] = (child.value.first.name = shuffler.random_new_name )
                    elsif child.is_a? RKelly::Nodes::ResolveNode
                        child.value = renamed_variables[child.value] if renamed_variables.has_key? child.value
                    else
                        child.each { |n| n.value = renamed_variables[n.value] if n.is_a? RKelly::Nodes::ResolveNode and renamed_variables.has_key? n.value }
                    end
                end
            end
        end
    end
end
