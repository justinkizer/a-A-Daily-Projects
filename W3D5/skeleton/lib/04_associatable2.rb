require_relative '03_associatable'

# Phase IV
module Associatable

  def has_one_through(name, through_name, source_name)

    define_method(name) do
      through_options = self.class.assoc_options[through_name]
      source_options = through_options.model_class.assoc_options[source_name]
      source_name = source_options.class_name.downcase
      through_name = through_options.class_name.downcase
      result = DBConnection.execute(<<-SQL, self.id)
        SELECT
          #{source_name}s.*
        FROM
          #{through_name}s
        JOIN
          #{source_name}s ON #{through_name}s.#{source_name}_id = #{source_name}s.id
        WHERE
          #{through_name}s.id = ?
      SQL
      result.map { |hash| source_name.capitalize.constantize.new(hash) }.first
    end

  end

end
