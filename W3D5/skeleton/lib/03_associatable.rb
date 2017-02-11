require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    @class_name.constantize
  end

  def table_name
    "#{@class_name.downcase}s"
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    @primary_key = options[:primary_key]
    @primary_key ||= :id
    @foreign_key = options[:foreign_key]
    @foreign_key ||= "#{name}_id".to_sym
    @class_name = options[:class_name]
    @class_name ||= name.to_s.camelcase
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    @primary_key = options[:primary_key]
    @primary_key ||= :id
    @foreign_key = options[:foreign_key]
    @foreign_key ||= "#{self_class_name.underscore}_id".to_sym
    @class_name = options[:class_name]
    @class_name ||= name.to_s.camelcase.singularize
  end
end

module Associatable
  # Phase IIIb

  def belongs_to(name, options = {})
    assoc_options[name] = BelongsToOptions.new(name, options)
    define_method(name) do
      foreign_key_value = self.send(self.class.assoc_options[name].foreign_key)
      target_class = self.class.assoc_options[name].model_class
      target_class.where(self.class.assoc_options[name].primary_key => foreign_key_value).first
    end
  end

  def has_many(name, options = {})
    assoc_options[name] = HasManyOptions.new(name, self.name, options)
    define_method(name) do
      target_class = self.class.assoc_options[name].model_class
      primary_key_value = self.id
      target_class.where(self.class.assoc_options[name].foreign_key => primary_key_value)
    end
  end

  def assoc_options
    @assoc_options ||= {}
  end
end

class SQLObject
  extend Associatable
  extend Searchable
end
