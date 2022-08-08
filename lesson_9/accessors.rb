# frozen_string_literal: true

# rubocop:disable Metrics/AbcSize
module Accessors
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*names)
      names.each do |name|
        var_name = "@#{name}".to_sym
        var_name_history = "@#{name}_history".to_sym
        instance_variable_set(var_name_history, [])

        define_method(name) { instance_variable_get(var_name) }

        define_method("#{name}=".to_sym) do |value|
          history = instance_variable_get(var_name_history) || []
          history << instance_variable_get(var_name)
          instance_variable_set(var_name, value)
          instance_variable_set(var_name_history, history)
        end

        define_method("#{name}_history".to_sym) { instance_variable_get(var_name_history) }
      end

      def strong_attr_accessor(name, class_name)
        var_name = "@#{name}".to_sym
        define_method(name) { instance_variable_get(var_name) }
        define_method("#{name}=".to_sym) do |value|
          raise TypeError, 'Не верное название класса' unless value.is_a? class_name

          instance_variable_set(var_name, value)
        end
      end
    end
  end
end
# rubocop:enable Metrics/AbcSize
