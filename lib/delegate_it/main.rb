#encoding: UTF-8
module DelegateIt
  def self.included(klass)
    klass.instance_eval do
      def delegate *methods, options
        @@delegated_settings ||= []
        methods.each do |method|
          @@delegated_settings.push(Struct.new(:name, :options).new(method, options))
        end
      end
    end
  end

  def method_missing(method, *)
    setting = @@delegated_settings.select do |s|
      s.name == method
    end.first

    if setting
      receiver = if self.respond_to?(setting.options[:to])
        self.send(setting.options[:to])
      else
        nil
      end

      if receiver
        receiver.send(method)
      elsif setting.options[:allow_nil]
        nil
      else
        receiver.send(method)
      end
    else
      super
    end
  end
end