# frozen_string_literal: true

module NotifySlack
  module Validation
    class ValidationError < StandardError
      def initialize(errors)
        @errors = errors
      end

      attr_reader :errors

      def message
        "#{self.class}: #{errors.messages.join(', ')}"
      end
    end

    class Errors
      def initialize
        @values = {}
      end

      def messages
        @values.map do
          |field, messages| messages.map { |m| "#{field} #{m}" }
        end.flatten
      end

      def add(field_name, message)
        (@values[field_name] ||= []).push(message)
      end

      def empty?
        @values.empty?
      end
    end

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def validations
        @validations ||= []
      end

      def validates(method_name)
        validations.push(method_name)
      end
    end

    def valid?
      validate
      errors.empty?
    end

    def validate!
      raise ValidationError.new(errors) unless valid?
    end

    def errors
      @errors ||= Errors.new
    end

    private

    def validate
      self.class.validations.each do |name|
        send(name)
      end
    end
  end
end
