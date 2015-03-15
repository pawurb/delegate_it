#encoding: UTF-8
require 'spec_helper'

class Dummy
  extend DelegateIt
  delegate :name, to: :has_name

  def has_name
    Struct.new(:name).new('name')
  end
end

describe 'DelegateIt' do
  subject do
    Dummy.new
  end

  describe "standard delegation" do
    it "works" do
      expect(subject.name).to eq 'name'
    end
  end
end

