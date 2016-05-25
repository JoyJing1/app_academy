require 'byebug'

class ModelBase
  attr_reader :id

  def self.find_by_id(id)
    table_name = self.to_s.downcase+'s'
    if table_name == 'replys'
      table_name = 'replies'
    end
    data = QuestionsDatabase.instance.get_first_row(<<-SQL, id)
    SELECT
      *
    FROM
      #{table_name}
    WHERE
      id = ?
    SQL
    self.new(data)
  end

  def self.all
    table_name = self.to_s.downcase+'s'
    if table_name == 'replys'
      table_name = 'replies'
    end
    data = QuestionsDatabase.instance.execute("SELECT * FROM #{table_name}")
    data.map { |datum| self.new(datum)}
  end

  def save
    table_name = self.class.to_s.downcase+'s'
    if table_name == 'replys'
      table_name = 'replies'
    end

    query = ''

    if @id
      query += "UPDATE #{table_name} SET "

      self.instance_variables.each do |inst_var|
        col_name = inst_var.to_s.chars.drop(1).join('')
        next if col_name == 'table_name' || col_name == 'id'

        val = self.instance_variable_get(inst_var.to_sym)
        query += "#{col_name} = '#{val}', "
      end

      query = query[0..-3]
      query << " WHERE id = #{@id}"

    else
      query += "INSERT INTO #{table_name} ("
      self.instance_variables.each do |inst_var|
        col_name = inst_var.to_s.chars.drop(1).join('')
        next if col_name == 'table_name' || col_name == 'id'
        query += "#{col_name}, "
      end

      query = query[0..-3] + ") VALUES ("
      self.instance_variables.each do |inst_var|
        next if inst_var == :@table_name || inst_var == :@id
        val = self.instance_variable_get(inst_var.to_sym)
        query += "'#{val}', "
      end

      query = query[0..-3] + ")"
    end
    puts query
    QuestionsDatabase.instance.execute(query)

  end

end
