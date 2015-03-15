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
  include DelegateIt

  delegate :name, :description, to: :product, allow_nil: true

  private

  def product
    ...
  end
end
````

### Supported options

  `allow_nil: true` - if the delegate does not exist method call will return nil.

PRs are welcome.
