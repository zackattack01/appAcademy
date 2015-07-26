module Saveable

  TABLE_HASH = {
    User: 'users',
    Reply: 'replies',
    Question: 'questions'
  }

  def col_names
    instance_variables.map { |var| var.to_s[1..-1] }[1..-1]
  end

  def vars
    instance_variables.map { |var| send(var.to_s[1..-1]) }[1..-1]
  end

  def update_hash
    col_names.zip(vars)
  end

  def save
    question_marks = "(#{(['?'] * vars.length).join(", ")})"
    if self.id.nil?
      QuestionsDatabase.instance.execute(<<-SQL, *vars)
      INSERT INTO
        #{TABLE_HASH[self.class.to_s.to_sym]} (#{ col_names.join(', ') })
      VALUES
        #{question_marks}
      SQL
      @id = QuestionsDatabase.instance.last_insert_row_id
    else
      update
    end
  end

  def update
    question_marks = col_names.product(['?']).map { |group| group.join(' = ') }.join(', ')
    full_vars = vars << send('id')
    QuestionsDatabase.instance.execute(<<-SQL, *full_vars)
    UPDATE
      #{TABLE_HASH[self.class.to_s.to_sym]}
    SET
      #{question_marks}
    WHERE
      id = ?
    SQL
  end
end