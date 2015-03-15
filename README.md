# Delegate it

delegate_it gem provides an easy way to use ActiveSupport like `delegate` method in your non Rails projects.

## Installation

In your Gemfile:

````ruby
gem 'delegate_it'
````

## Usage

````ruby
require 'delegate_it'

class Cowboy
  extend DelegateIt
  attr_reader :pouch, :pistol

  delegate :name, to: :horse, prefix: true
  delegate :money, to: :pouch, allow_nil: true
  delegate :bullets, to: :pistol, allow_nil: true, prefix: :gun

  def horse
    Struct.new(:name).new('Jolly Jumper')
  end
end

cowboy = Cowboy.new
cowboy.horse_name # => 'Jolly Jumper'
cowboy.money # => nil
cowboy.gun_bullets # => nil

````

### Supported options

`allow_nil: true` - if the delegate does not exist method call will return nil.

`prefix: true` - prefix delegated method name with the delegate or custom name.


### Status

PRs are welcome.
