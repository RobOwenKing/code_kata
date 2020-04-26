require_relative 'string_methods'

def eval_expr(terms)
  value = terms.shift.to_i
  until terms.length <= 0
    value = value.send(terms[0].to_sym, terms[1].to_i)
    terms = terms.drop(2)
  end
  value
end

def eval_list(terms)
  terms = terms.slice(1..-1).map!(&:to_i)
  terms.reduce(terms[0].to_sym)
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
    terms = self.split
    operators.include?(terms[0]) ? eval_list(terms) : eval_expr(terms)
  end
end
