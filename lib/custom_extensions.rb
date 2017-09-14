class Array
  def nested_tree() # Post for example
    stack = [] # Post for example
    result = []
    self.order("lft").each do |node|
      if stack.empty?
        stack.push({:node => node, :children => []})
        result << stack.last
        next
      end

      if stack.last[:node].lft < node.lft and node.lft < stack.last[:node].rgt
        child = {:node => node, :children => []}
        stack.last[:children] << child
        if node.rgt + 1 == stack.last[:node].rgt
          stack.pop
        end
        unless node.leaf? # (node.rgt - node.lft == 1)
          stack.push(child)
        end
      else
        stack.pop
        stack.push({:node => node, :children => []})
        result << stack.last
      end
    end
  end
end
