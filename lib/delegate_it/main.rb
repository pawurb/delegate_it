#encoding: UTF-8
module DelegateIt
  def delegate *methods, options
    methods.each do |method|
      define_method method do |*args|
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
