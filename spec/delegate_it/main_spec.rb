#encoding: UTF-8
require 'spec_helper'

class Dummy
  include DelegateIt
  delegate :name, :surname, to: :name_delegate
  delegate :hello, to: :no_exist, allow_nil: true
  delegate :there, to: :there_delegate, allow_nil: true
  delegate :one, to: :args_delegate
  delegate :print, to: :args_delegate

  def name_delegate
    Struct.new(:name, :surname).new('name_val', 'surname_val')
  end

  def there_delegate
    Struct.new(:there).new('there_val')
  end

  def args_delegate
    dynamic_class = Class.new do
      def one count
        ('one '* count).strip
      end

      def print(word, count)
        ((word+' ') * count).strip
      end
    end

    dynamic_class.new
  end
end

describe 'DelegateIt' do
  subject do
    Dummy.new
  end

  describe "standard delegation" do
    context "without parameters" do
      it "works" do
        expect(subject.name).to eq 'name_val'
        expect(subject.surname).to eq 'surname_val'
      end
    end

    context "with parameters" do
      it "works with one" do
        expect(subject.one(3)).to eq 'one one one'
      end

      it "works with more params" do
        expect(subject.print('more', 3)).to eq 'more more more'
      end
    end
  end

  describe "allow_nil case" do
    context "receiver is nil" do
      it "returns nil" do
        expect(subject.hello).to eq nil
      end
    end

    context "receiver exists" do
      it "delegates like usual" do
        expect(subject.there).to eq 'there_val'
      end
    end
  end

  describe "method does not exist" do
    it "raises no_method error" do
      expect do
        subject.not_there
      end.to raise_error(NoMethodError)
    end
  end
end

