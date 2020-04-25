require_relative 'string_methods'

class String
  def eval_expr
    value = self.match(/\A\d+/)[0].to_i
    # expression = self.delete_prefix(value.to_s)
  end

  def eval_list
    list = self.split.slice(1..-1).map!(&:to_i)
    case self[0]
    when '+' then list.reduce(:+)
    when '-' then list.reduce(:-)
    when '*' then list.reduce(:*)
    when '/' then list.reduce(:/)
    end
  end

  def calculate
    operators = ['+', '-', '*', '/']
    operators.include?(self[0]) ? self.eval_list : self.eval_expr
  end
end
