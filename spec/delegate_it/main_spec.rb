#encoding: UTF-8
require 'spec_helper'

class Dummy
  include DelegateIt
  delegate :name, to: :name_delegate
  delegate :hello, to: :no_exist, allow_nil: true
  delegate :there, to: :there_delegate, allow_nil: true

  def name_delegate
    Struct.new(:name).new('name_val')
  end

  def there_delegate
    Struct.new(:there).new('there_val')
  end
end

describe 'DelegateIt' do
  subject do
    Dummy.new
  end

  describe "standard delegation" do
    it "works" do
      expect(subject.name).to eq 'name_val'
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

