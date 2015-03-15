#encoding: UTF-8
module DelegateIt
  def delegate *methods, options
    methods.each do |method|
      method_name = if options[:prefix] && options[:prefix].is_a?(Symbol)
        "#{options[:prefix]}_#{method}"
      elsif options[:prefix]
        "#{options[:to]}_#{method}"
      else
        method
      end

      define_method method_name do |*args|
        receiver = self.send(options[:to])
        if options[:allow_nil] && !receiver
          nil
        else
          receiver.send(method, *args)
        end
      end
    end
  end
end
