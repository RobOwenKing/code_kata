require_relative 'string_methods'

def eval_expr(expression)
  value = self.match(/\A\d+/)[0].to_i
  # expression = self.delete_prefix(value.to_s)
end

def eval_list(expression)
  terms = expression.slice(1..-1).map!(&:to_i)
  terms.reduce(expression[0].to_sym)
  # case self[0]
  # when '+' then list.reduce(:+)
  # when '-' then list.reduce(:-)
  # when '*' then list.reduce(:*)
  # when '/' then list.reduce(:/)
  # end
end

class String
  def calculate
    operators = ['+', '-', '*', '/']
    expression = self.split
    operators.include?(expression[0]) ? eval_list(expression) : eval_expr(expression)
  end
end
