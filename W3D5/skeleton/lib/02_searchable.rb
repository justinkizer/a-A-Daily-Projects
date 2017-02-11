require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    where_line = params.keys.map { |filter| "#{filter} = ?" }.join(" AND ")
    result = DBConnection.execute(<<-SQL, *params.values)
      SELECT
        *
      FROM
        #{self.name.downcase}s
      WHERE
        #{where_line}
    SQL
    result.map { |hash| self.new(hash) }
  end
end

class SQLObject
  extend Searchable
end
