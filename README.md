# Delegate it

delegate_it gem provides an easy way to use ActiveSupport like `delegate` method in your non Rails projects.

## Installation

In your Gemfile:

````ruby
gem 'delegate_it'
````

## Usage

```` ruby
class Offer
  extend DelegateIt

  delegate :name, :description, to: :product
  delegate :brand, to: :manufacturer, allow_nil: true

  def manufacturer
    nil
  end

  private

  def product
    Struct.new(:name, :description)
    .new('Great product', 'Awesome!')
  end
end

offer = Offer.new
offer.name # => 'Great product'
offer.description # => 'Awesome!'
offer.brand # => nil

````

### Supported options

  `allow_nil: true` - if the delegate does not exist method call will return nil.

PRs are welcome.
