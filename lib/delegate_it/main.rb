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

  def method_missing(method, *args)
    setting = @@delegated_settings.select do |s|
      s.name == method
    end.first

    if setting
      receiver = if self.respond_to?(setting.options[:to], true)
        self.send(setting.options[:to])
      else
        nil
      end

      if setting.options[:allow_nil] && !receiver
        nil
      else
        receiver.send(method, *args)
      end
    else
      super
    end
  end
end