#encoding: UTF-8
module DelegateIt
  def delegate *methods, receiver
    define_method :method_missing do |method, *args, &block|
      if methods.include?(method)
        self.send(receiver[:to]).send(method, *args, &block)
      else
        raise NoMethodError
      end
    end
  end
end