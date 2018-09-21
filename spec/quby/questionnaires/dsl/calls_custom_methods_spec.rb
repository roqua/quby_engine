# frozen_string_literal: true

require 'spec_helper'

module Quby::Questionnaires::DSL
  describe CallsCustomMethods do

    class TestCustomMethod
      prepend CallsCustomMethods

      attr_reader :test
      def initialize(*args)
        @test = 'attribute'
      end
    end

    let(:custom_methods) { {custom: -> { 'custom_method' }} }
    let(:test_object) { TestCustomMethod.new(custom_methods: custom_methods) }

    describe 'prepending' do
      it 'does not skip the actual initializer' do
        expect(test_object.test).to eq('attribute')
      end
    end

    describe '#method_missing' do
      it 'allows the class to receive messages defined in custom_methods' do
        expect(test_object.custom).to eq('custom_method')
      end
    end

    describe '#respond_to_missing?' do
      it 'also considers custom methods' do
        expect(test_object.send(:respond_to_missing?, :custom)).to eq(true)
      end
    end
  end
end
