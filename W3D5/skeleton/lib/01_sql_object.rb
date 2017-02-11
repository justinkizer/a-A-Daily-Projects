require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject

  def self.columns
    unless @column_names
      @column_names = DBConnection.execute2(<<-SQL)
        SELECT
          *
        FROM
        #{self.table_name}
      SQL
    end
    @column_names.first.map(&:to_sym)
  end

  def self.finalize!
    self.columns.each do |column_name|
      define_method(column_name) do
        attributes[column_name]
      end
      define_method("#{column_name}=") do |value|
        attributes[column_name] = value
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= name.tableize
  end

  def self.all
    self.parse_all(DBConnection.execute(<<-SQL)
      SELECT
        #{name.downcase}s.*
      FROM
        #{name.downcase}s
    SQL
    )
  end

  def self.parse_all(results)
    results.map do |hash|
      self.new(hash)
    end
  end

  def self.find(id)
    result = DBConnection.execute(<<-SQL, id)
      SELECT DISTINCT
        *
      FROM
        #{name.downcase}s
      WHERE
        ? = #{name.downcase}s.id
    SQL
    result.empty? ? nil : self.new(result.first)
  end

  def initialize(params = {})

    params.each do |attr_name, value|
      attr_name = attr_name.to_sym
      raise "unknown attribute '#{attr_name}'" unless self.class.columns.include?(attr_name)
      self.send("#{attr_name}=", value)
    end

  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    self.class.columns.map { |attr_name| self.send("#{attr_name}") }
  end

  def insert
    column_names = self.class.columns
    parameters = (["?"] * column_names.length).join(", ")
    values = attribute_values
    DBConnection.execute(<<-SQL, *values)
      INSERT INTO
        #{self.class.name.downcase}s (#{column_names.join(", ")})
      VALUES
        (#{parameters})
    SQL
    self.id = DBConnection.last_insert_row_id unless self.id
  end

  def update
    column_names = self.class.columns
    parameters = column_names.map { |col| "#{col} = ?" }.join(", ")
    values = attribute_values
    DBConnection.execute(<<-SQL, *values)
      UPDATE
        #{self.class.name.downcase}s
      SET
        #{parameters}
      WHERE
        id = #{self.id}
    SQL
  end

  def save
    self.id ? update : insert
  end
end
