
class Symbol
  def plus
    helper = self.to_s.ord
    helper+=1
    return helper.chr.to_sym
  end

  def minus
    helper = self.to_s.ord
    helper-=1
    return helper.chr.to_sym
  end
end
